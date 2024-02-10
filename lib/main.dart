import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:re3aity/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:re3aity/Provider/Screens/MyReservation/Bloc/FinishedCubit/FinishedCubit.dart';
import 'package:re3aity/Provider/Screens/MyReservation/Bloc/RemoveCubit/RemoveCubit.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_Cubit.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_Cubit.dart';
import 'package:re3aity/Splash/splash_screen.dart';
import 'package:re3aity/User/screens/Profile/Edit_Profile/bloc/Edit_Cubit.dart';
import 'package:re3aity/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:re3aity/User/screens/Sections/Sections.dart';
import 'package:re3aity/User_or_Provider/UserOrProvider.dart';
import 'package:re3aity/notifications.dart';
import 'package:re3aity/theme/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterCubit.dart';
import 'package:re3aity/Provider/Screens/Auth/Confim_Code/Bloc/VerifyCubit.dart';
import 'package:re3aity/Provider/Screens/Auth/Login/Bloc/ProviderLoginCubit.dart';
import 'package:re3aity/Provider/Screens/Auth/SignUp/Bloc/cubit.dart';
import 'package:re3aity/User/screens/Auth/Confim_Code/bloc/ConfirmCodeCubit.dart';
import 'package:re3aity/User/screens/Auth/Confirm_Forget_Password/Bloc/Confirm_Forget_Cubit.dart';
import 'package:re3aity/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_Cubit.dart';
import 'package:re3aity/User/screens/Auth/NewPassword/Bloc/NewPass_Cubit.dart';
import 'package:re3aity/User/screens/Auth/SignUp/Bloc/Cubit.dart';
import 'package:re3aity/User/screens/SingleSection/Bloc/AddReservationCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'User/screens/Auth/Login/Bloc/Cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.init();
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String? login = _pref.getString("api_token");
  String? admin = _pref.getString("admin");
  Widget? screen;
  if(login == null){
    screen = UserOrProvider();
  }else if(login != null && admin == "user"){
    screen = Sections(skip: false);
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
  final Widget? screen;
  MyCare({this.screen});

  @override
  _MyCareState createState() => _MyCareState();
}

class _MyCareState extends State<MyCare> {

  @override
  void initState() {
    NotificationHelper.onInit();
    super.initState();
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
          primaryColor: ThemeColor.mainPurple,
          hintColor: ThemeColor.lighterGreyText,
          fontFamily: "Cairo-Regular",
          colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: ThemeColor.mainPurple,
                onPrimary: Colors.transparent,
                secondary: ThemeColor.lighterGreyText,
                onSecondary: Colors.transparent,
                error: ThemeColor.mainRed,
                onError: ThemeColor.mainRed,
                background: Colors.transparent,
                onBackground: Colors.transparent,
                surface: Colors.transparent,
                onSurface: Colors.transparent,
            ),
        ),
        home: SplashScreen(screen: widget.screen),
      ),
    );
  }
}