import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Confim_Code/Confirm_Code.dart';
import 'package:re3aity/User/screens/Auth/SignUp/Bloc/Cubit.dart';
import 'package:re3aity/User/screens/Auth/SignUp/Bloc/state.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomRegisterIcon.dart';
import 'package:re3aity/common/CustomTextField.dart';
import 'package:re3aity/common/CustonSnackBar.dart';
import 'package:re3aity/social_login/social_helper.dart';
import 'package:re3aity/theme/color.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
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
                        duration: 1,
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

                      //============ SignUp Card =============
                      AnimatedWidgets(
                        duration: 1.5,
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
                                    'انشاء حساب',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  //=========== اسم المستخدم =============
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: false,
                                    label: "اسم المستخدم",
                                    inputType: TextInputType.name,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/username.png"),
                                    validate: (value) {
                                      if(value!.isEmpty) {
                                        return "من فضلك ادخل اسم المستخدم";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.name = value;
                                    },
                                  ),

                                  //=========== رقم الجوال =============
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
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
                                      if(value!.isEmpty) {
                                        return "برجاء ادخل رقم الجوال";
                                      }else if (value.length < 9 || value.length > 9){
                                        return "يشترط رقم الجوال 9 أرقام";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.phone = value;
                                    },
                                  ),

                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: false,
                                    label: "البريد الإلكتروني",
                                    inputType: TextInputType.emailAddress,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/email.png"),
                                    validate: (val){
                                      if(val!.isEmpty){
                                        return "برجاء ادخال البريد الالكتروني";
                                      }else if(!val.contains('@') || !val.contains('.')){
                                        return "EX: example@mail.com";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.email = value;
                                    },
                                  ),

                                  //=========== كلمة المرور =============
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: true,
                                    label: "كلمة المرور",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (value) {
                                      if(value!.isEmpty) {
                                        return "برجاء ادخل كلمة المرور";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.password = value;
                                    },
                                  ),

                                  //=========== تاكيد كلمة المرور =============
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: true,
                                    label: "تأكيد كلمة المرور",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (value) {
                                      if(value!.isEmpty) {
                                        return "من فضلك ادخل كلمة المرور";
                                      }else if(value != cubit.password){
                                        return "كلمة المرور غير متطابقة";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.confirmpass = value;
                                    },
                                  ),

                                  SizedBox(height: 10),

                                  //=========== تسجيل =============
                                  BlocConsumer<SignUpCubit, SignUpState>(
                                    listener: (_, state){
                                      if(state is SignUpErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is SignUpSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmCode()));
                                        print("============================= تم التسجيل بنجاح =========================");

                                      }
                                    },
                                    builder: (context, state) {
                                      return state is SignUpLoadingState
                                          ? CenterLoading()
                                          : CustomButton(
                                              text: "تسجيل",
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: 40,
                                              onTap: () {
                                                if (_formKey.currentState!.validate()) {
                                                  cubit.SignUp();
                                                }
                                              },
                                            );
                                    },
                                  ),

                                  Divider(),

                                  BlocConsumer<SignUpCubit, SignUpState>(
                                    listener: (_, state){
                                      if(state is SignUpErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is SignUpSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmCode()));
                                        print("============================= تم التسجيل بنجاح =========================");
                                      }
                                    },
                                    builder: (context, state) {
                                      return state is GoogleSignUpLoadingState
                                          ? CenterLoading()
                                          : InkWell(
                                              onTap: () {
                                                loginWithGoogle.call().then((value) {
                                                  cubit.SignUpWithGoogle(value);
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "التسجيل عن طريق جوجل",
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

                      //=========== لديك حساب ؟ =============
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: 0,
                        virticaloffset: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'لديك حساب؟',
                              style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.darkerGreyText,
                              ),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'تسجيل الدخول',
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