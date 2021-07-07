import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Auth/Login/login_screen.dart';
import 'package:lastre3ayty/User/screens/Auth/NewPassword/Bloc/NewPass_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/NewPassword/Bloc/NewPass_State.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/common/CustonSnackBar.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = NewPassCubit.get(context);

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
                                    'الرجاء تعيين كلمة مرور جديدة',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                                  //=================== كلمة المرور ==================
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 2,
                                    secureText: true,
                                    label: "كلمة المرور",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (val){
                                      if(val.isEmpty){
                                        return "برجاء ادخال كلمة المرور";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.new_pass = value;
                                    },
                                  ),

                                  //=================== تأكيد كلمة المرور ==================
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 2,
                                    secureText: true,
                                    label: "تأكيد كلمة المرور",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (val){
                                      if(val.isEmpty){
                                        return "برجاء ادخال كلمة المرور";
                                      }else if(val != cubit.new_pass){
                                        return "كلمة المرور غير متطابقة";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.confirm_pass = value;
                                    },
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                  //======================== تعييين ========================
                                  BlocConsumer<NewPassCubit, NewPassState>(
                                    listener: (_, state){
                                      if(state is NewPassErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is NewPassSuccessState){
                                        Navigator.push(_, MaterialPageRoute(builder: (_) => LoginScreen()));
                                        print("<==<==<==<==<==<==<==<== تم تغيير كلمة المرور بنجاح ==>==>==>==>==>==>==>==>");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is NewPassLoadingState
                                          ? CenterLoading()
                                          : CustomButton(
                                              text: "تعيين",
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: 40,
                                              onTap: () {
                                                if (formKey.currentState.validate()) {
                                                  cubit.postNewPass();
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
