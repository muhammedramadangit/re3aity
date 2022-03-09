import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/Bloc/FinishedCubit/FinishedCubit.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/Bloc/RemoveCubit/RemoveCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_Cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_Cubit.dart';
import 'package:lastre3ayty/Splash/splash_screen.dart';
import 'package:lastre3ayty/User/screens/Profile/Edit_Profile/bloc/Edit_Cubit.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:lastre3ayty/User/screens/Sections/Sections.dart';
import 'package:lastre3ayty/User_or_Provider/UserOrProvider.dart';
import 'package:lastre3ayty/theme/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Confim_Code/Bloc/VerifyCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Login/Bloc/ProviderLoginCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/SignUp/Bloc/cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Confim_Code/bloc/ConfirmCodeCubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Confirm_Forget_Password/Bloc/Confirm_Forget_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/NewPassword/Bloc/NewPass_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/SignUp/Bloc/Cubit.dart';
import 'package:lastre3ayty/User/screens/SingleSection/Bloc/AddReservationCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'User/screens/Auth/Login/Bloc/Cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String login = _pref.getString("api_token");
  String admin = _pref.getString("admin");
  Widget screen;
  if(login == null){
    screen = UserOrProvider();
  }else if(login != null && admin == "user"){
    screen = Sections();
  }else if(login != null && admin == "advertiser"){
    screen = ProviderMainDrawer(appBarTitle: "حجوزاتي", index: 0);
  }else{
    screen = UserOrProvider();
    print("login api Token : ............ $login");
    print("type of User : ............ $admin");
  }
  runApp(MyCare(screen: screen));
}

class MyCare extends StatefulWidget {
  final Widget screen;
  MyCare({this.screen});

  @override
  _MyCareState createState() => _MyCareState();
}

class _MyCareState extends State<MyCare> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid;

  var initializationSettingsIos;

  var initializationSettings;

  void _showNotification(var title , var body)async{
    await _demoNotification(title , body);
  }

  Future<void> _demoNotification(var title , var body)async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel_Name', 'channel_Description',importance: Importance.max,
        priority: Priority.high , ticker: 'test ticker');
    var iosChannelSpecifics = IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosChannelSpecifics);
    flutterLocalNotificationsPlugin.show(0,title,body, platformChannelSpecifics,payload: 'Custom_Sound');
  }

  Future onDidReceiveLocalNotification(int id , String title , String body ,String payload)async{
    await showDialog(context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: ()async{
              Navigator.of(context , rootNavigator: true).pop();
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondRoute()));
            },
            isDefaultAction: true,
            child: Text('ok'),
          )
        ],
      ),
    );
  }

  Future onSelectNotification(String payload)async{
    if(payload!=null){
      // debugPrint('Notification payload $payload');
    }
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> UserOrProvider()));
  }

  @override
  void initState() {
    print("hellllllllllllllllllooooooooooooo");
    // _showNotification("message['notification']['title']","message['notification']['body']");
    initializationSettingsAndroid = AndroidInitializationSettings('kafooios');
    initializationSettingsIos = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIos);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    super.initState();
    // FlutterRingtonePlayer.playNotification();
// FirebaseMessaging().getToken().then((value) => print(value));
    FirebaseMessaging().configure(

      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotification(message['notification']['title'],message['notification']['body']);
        FlutterRingtonePlayer.playNotification(
          looping: false, // Android only - API >= 28
          volume: 0.1, // Android only - API >= 28
          asAlarm: false, // Android only - all APIs
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _showNotification(message['notification']['title'],message['notification']['body']);
        FlutterRingtonePlayer.playNotification(
          looping: false, // Android only - API >= 28
          volume: 0.1, // Android only - API >= 28
          asAlarm: false, // Android only - all APIs
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _showNotification(message['notification']['title'],message['notification']['body']);
        FlutterRingtonePlayer.playNotification(
          looping: false, // Android only - API >= 28
          volume: 0.1, // Android only - API >= 28
          asAlarm: false, // Android only - all APIs
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //=========== user Bloc ================
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => ConfirmCodeCubit()),
        BlocProvider(create: (_) => ForgetPassCubit()),
        BlocProvider(create: (_) => NewPassCubit()),
        BlocProvider(create: (_) => ConfirmForgetCubit()),
        BlocProvider(create: (_) => AddReservationCubit()),
        BlocProvider(create: (_) => EditProfileCubit()),
        BlocProvider(create: (_) => ProfileCubit()),

        //=========== provider Bloc ================
        BlocProvider(create: (_) => ProviderLoginCubit()),
        BlocProvider(create: (_) => ProviderSignUpCubit()),
        BlocProvider(create: (_) => ProviderVerifyCubit()),
        BlocProvider(create: (_) => CompleteRegisterCubit()),
        BlocProvider(create: (_) => ProviderProfileCubit()),
        BlocProvider(create: (_) => EditProviderCubit()),
        BlocProvider(create: (_) => RemoveCubit()),
        BlocProvider(create: (_) => FinishedCubit()),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'رعايتي',
        theme: ThemeData(
          primaryColor: ThemeColor.mainPurple, //Color(0xff0092ce),
          accentColor: ThemeColor.lighterGreyText,
          fontFamily: "Cairo-Regular",
        ),
        home: SplashScreen(screen: widget.screen),
      ),
    );
  }
}



class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('AlertPage'),),
        body: Center(child: TextButton(child: Text('go Back ...'),onPressed: (){
          Navigator.pop(context);
        },)));
  }
}