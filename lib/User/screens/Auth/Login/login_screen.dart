import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Forget_Password/Forget_Password_Screen.dart';
import 'package:re3aity/User/screens/Auth/Login/Bloc/Cubit.dart';
import 'package:re3aity/User/screens/Auth/Login/Bloc/state.dart';
import 'package:re3aity/User/screens/Auth/SignUp/SignUpScreen.dart';
import 'package:re3aity/User/screens/Sections/Sections.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomRegisterIcon.dart';
import 'package:re3aity/common/CustomTextField.dart';
import 'package:re3aity/common/CustonSnackBar.dart';
import 'package:re3aity/social_login/social_helper.dart';
import 'package:re3aity/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? skip;

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((v) {
      LoginCubit.get(context).token = v;
    });
    super.initState();
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
                                      if(value!.isEmpty){
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
                                      if(value!.isEmpty){
                                        return "برجاء ادخال كلمة المرور";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.password = value;
                                    },
                                  ),

                                  SizedBox(height: 5),

                                  //=========== هل نسيت كلمة السر ؟ =============
                                  InkWell(
                                    onTap: () {
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
                                        customSnackBar(_, state.error);
                                      }else if(state is LoginSuccessState){
                                        Navigator.pushAndRemoveUntil(_, MaterialPageRoute(builder: (_) => Sections(skip: false)), (route) => false);
                                        print("=============================تم تسجيل الدخول بنجاح=========================");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is LoginLoadingState
                                          ? CenterLoading()
                                          : CustomButton(
                                              onTap: () {
                                                if (_formKey.currentState!.validate()) {
                                                  cubit.login();
                                                }
                                              },
                                              text: "تسجيل",
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: 40,
                                            );
                                    },
                                  ),

                                  Divider(),

                                  BlocConsumer<LoginCubit, LoginState>(
                                    listener: (context, state) {
                                      if(state is LoginErrorState){
                                        customSnackBar(context, state.error);
                                      }else if(state is LoginSuccessState){
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Sections(skip: false)), (route) => false);
                                        print("=============================تم تسجيل الدخول عن طريق جوجل بنجاح=========================");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is LoginLoadingGoogleState
                                          ? CenterLoading()
                                          : InkWell(
                                              onTap: () {
                                                loginWithGoogle.call().then((value) {
                                                  cubit.loginWithGoogle(value);
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "الدخول عن طريق جوجل",
                                                    style: TextStyle(
                                                      color: ThemeColor.blackTextColor,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Image.asset("assets/icons/google.png", height: 20, width: 20),
                                                ],
                                              ),
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

                      skipButton(context),


                    ],
                  ),
                ),
              ),
            ),

            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: skipButton(context),
            // )
          ],
        ),
      ),
    );
  }

  //=============================== SKIP BUTTON ==================================
  Widget skipButton(BuildContext context){
    return AnimatedWidgets(
      duration: 2,
      horizontalOffset: 50.0,
      virticaloffset: 0.0,
      child: InkWell(
        onTap: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool("skip", true);
          skip=pref.getBool("skip");
          print("=============================================$skip");
          Navigator.push(context, MaterialPageRoute(builder: (_)=> Sections(skip: skip!)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 25,
              width: 25,
              margin: EdgeInsets.all(15),
              color: Colors.transparent,
              child: Center(
                child: Image.asset("assets/icons/skip.png", color: Theme.of(context).primaryColor),
              ),
            ),
            Text(
              'تخطي',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Cairo-Bold',
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
