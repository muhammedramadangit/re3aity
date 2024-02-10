import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:re3aity/Provider/Screens/Auth/Login/Bloc/ProviderLoginCubit.dart';
import 'package:re3aity/Provider/Screens/Auth/Login/Bloc/ProviderLoginState.dart';
import 'package:re3aity/Provider/Screens/Auth/SignUp/SignUpScreen.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomRegisterIcon.dart';
import 'package:re3aity/common/CustomTextField.dart';
import 'package:re3aity/common/CustonSnackBar.dart';
import 'package:re3aity/social_login/social_helper.dart';
import 'package:re3aity/theme/color.dart';

class ProviderLogin extends StatefulWidget {
  @override
  _ProviderLoginState createState() => _ProviderLoginState();
}

class _ProviderLoginState extends State<ProviderLogin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    _firebaseMessaging.getToken().then((v) {
     print(v);
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = ProviderLoginCubit.get(context);
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
                                    'تسجيل الدخول كمقدم خدمة',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: ThemeColor.mainPurple,
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  //============== رقم الجوال ===============
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
                                    validate: (val){
                                      if(val!.isEmpty){
                                        return "برجاء إدخال رقم الجوال";
                                      }else if(val.length < 9 && val.length > 9){
                                        return "يشترط رقم الجوال 9 أرقام";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.phone = value;
                                    },
                                  ),

                                  //=============== كلمة المرور ================
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: true,
                                    label: "كلمة المرور",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (val){
                                      if(val!.isEmpty){
                                        return "برجاء إدخال كلمة المرور";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.password = value;
                                    },
                                  ),

                                  SizedBox(height: 15),

                                  //================= تسجييل =====================
                                  BlocConsumer<ProviderLoginCubit, ProviderLoginState>(
                                    listener: (_, state){
                                      if(state is ProviderLoginErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is ProviderLoginSuccessState){
                                        Navigator.pushAndRemoveUntil(
                                            _,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProviderMainDrawer(
                                                appBarTitle: "حجوزاتي",
                                                index: 0,
                                              ),
                                            ),
                                            (route) => false);
                                        print("============ تم تسجيل الدخول بنجاح ===============");
                                      }
                                    },
                                    builder: (context, state){
                                          return state is ProviderLoginLoadingState
                                              ? CenterLoading()
                                              : CustomButton(
                                                  text: "تسجيل",
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  height: 40,
                                                  onTap: () {
                                                    if (_formKey.currentState!.validate()) {
                                                      cubit.postProviderLogin();
                                                    }
                                                  },
                                                );
                                        },
                                      ),

                                  Divider(),

                                  BlocConsumer<ProviderLoginCubit, ProviderLoginState>(
                                    listener: (_, state){
                                      if(state is ProviderLoginErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is ProviderLoginSuccessState){
                                        Navigator.pushAndRemoveUntil(
                                            _,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProviderMainDrawer(
                                                    appBarTitle: "حجوزاتي",
                                                    index: 0,
                                                  ),
                                            ),
                                                (route) => false);
                                        print("============ تم تسجيل الدخول بنجاح ===============");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is ProviderSocialLoginLoadingState
                                          ? CenterLoading()
                                          : InkWell(
                                        onTap: () {
                                          loginWithGoogle.call().then((value) {
                                            cubit.postProviderLoginWithGoogle(value);
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

                      // ==================== ليس لديك حساب ؟ ====================
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
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderSignUp())),
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

                      // InkWell(
                      //   onTap: () {},
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
