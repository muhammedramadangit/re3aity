import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/User/screens/Auth/Forget_Password/Forget_Password_Screen.dart';
import 'package:lastre3ayty/User/screens/Auth/Login/Bloc/Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Login/Bloc/state.dart';
import 'package:lastre3ayty/User/screens/Auth/SignUp/SignUpScreen.dart';
import 'package:lastre3ayty/User/screens/Sections/Sections.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/theme/color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.getToken().then((v) {
      LoginCubit.get(context).token = v;
    });    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //============ Logo Position ===========
                      AnimatedWidgets(
                        duration: 2,
                        horizontalOffset: 0,
                        virticaloffset: 50,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/app_logo.png'),
                            ),
                          ),
                        ),
                      ),

                      //============ Login Card =============
                      AnimatedWidgets(
                        duration: 2,
                        horizontalOffset: 0,
                        virticaloffset: 100,
                        child: Container(
                          // height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Card(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  //=========== رقم الجوال =============
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 5,
                                    secureText: false,
                                    label: "رقم الجوال",
                                    inputType: TextInputType.phone,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/phone.png"),
                                    suffixIcon: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Divider(),
                                        Text("+966", textDirection: TextDirection.ltr, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                                      ],
                                    ),
                                    validate: (value) {
                                      if(value.isEmpty){
                                        return "برجاء ادخال رقم الجوال";
                                      }else if (value.length < 9 || value.length > 9){
                                        return "يشترط رقم الجوال 9 أرقام";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.phone = value;
                                    },
                                  ),

                                  //=========== كلمة المرور =============
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 5,
                                    secureText: true,
                                    label: "كلمة المرور",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (value) {
                                      if(value.isEmpty){
                                        return "برجاء ادخال كلمة المرور";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.password = value;
                                    },
                                  ),

                                  SizedBox(height: 5),

                                  //=========== هل نسيت كلمة السر ؟ =============
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=> ForgetPassword()));
                                    },
                                    child: Text(
                                      'هل نسيت كلمة المرور؟',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  //=========== تسجيل الدخول =============
                                  BlocConsumer<LoginCubit, LoginState>(
                                    listener: (_, state){
                                      if(state is LoginErrorState){
                                        Scaffold.of(_).showSnackBar(SnackBar(
                                          backgroundColor: Theme.of(_).primaryColor,
                                          content: Text(state.error,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontSize: 12),),
                                        ));
                                      }else if(state is LoginSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => Sections()));
                                        print("=============================تم تسجيل الدخول بنجاح=========================");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is LoginLoadingState ? Center(
                                        child: SpinKitChasingDots(
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ) : CustomButton(
                                        onTap: () {
                                          if(_formKey.currentState.validate()){
                                            cubit.login();
                                          }
                                          print("button pressed");
                                        },
                                        text: "تسجيل",
                                        width: MediaQuery.of(context).size.width / 2,
                                        height: 40,
                                      );
                                    },
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //=========== ليس لديك حساب ؟ =============
                      AnimatedWidgets(
                        duration: 2,
                        horizontalOffset: 0,
                        virticaloffset: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ليس لديك حساب؟',
                              style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.darkerGreyText,
                              ),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignUpScreen()));
                              },
                              child: Text(
                                'انشاء حساب',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Cairo-Bold',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //=========== تخطي =============
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (_) => Sections()));
                      //   },
                      //   child: Text(
                      //     'تخطي',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: 'Cairo-Bold',
                      //       color: Theme.of(context).primaryColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
