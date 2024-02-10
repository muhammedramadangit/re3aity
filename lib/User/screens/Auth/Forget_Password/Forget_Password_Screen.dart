import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Confirm_Forget_Password/Confirm_Forget_Password.dart';
import 'package:re3aity/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_Cubit.dart';
import 'package:re3aity/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_State.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomRegisterIcon.dart';
import 'package:re3aity/common/CustomTextField.dart';
import 'package:re3aity/common/CustonSnackBar.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = ForgetPassCubit.get(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            //=============== background image ==============
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            //================ main body ====================
            Align(
              alignment: Alignment.center,
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

                    //============ Forget Password Card =============
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
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'الرجاء ادخال بريدك الإلكتروني',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  //=============== رقم الجوال ================
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 30,
                                    secureText: false,
                                    label: "البريد الإلكتروني",
                                    inputType: TextInputType.emailAddress,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/email.png"),
                                    // suffixIcon: Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Divider(),
                                    //     Text("+966", textDirection: TextDirection.ltr, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12)),
                                    //     SizedBox(width: 5),
                                    //   ],
                                    // ),
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

                                  //=============== رقم الجوال ================
                                  BlocConsumer<ForgetPassCubit, ForgetPassState>(
                                    listener: (_, state){
                                      if(state is ForgetPassErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is ForgetPassSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmForgetPassword()));
                                        print("<=<=<=<=<<==<<==<<==<<== Done ==>==>==>==>==>==>==>==>");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is ForgetPassLoadingState
                                          ? CenterLoading()
                                          : CustomButton(
                                              text: "ارسال",
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: 40,
                                              onTap: () {
                                                if (formKey.currentState!.validate()) {
                                                  cubit.postForgetPass();
                                                }
                                              },

                                      );
                                    },
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
