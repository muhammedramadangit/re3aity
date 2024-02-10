import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Confim_Code/bloc/ConfirmCodeCubit.dart';
import 'package:re3aity/User/screens/Auth/Confim_Code/bloc/confirmCodeState.dart';
import 'package:re3aity/User/screens/Sections/Sections.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustonSnackBar.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ConfirmCode extends StatefulWidget {
  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = ConfirmCodeCubit.get(context);
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
                key: formKey,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'الرجاء ادخال كود التحقق',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: 15),

                                  //================== كود التحقق ================
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.04),
                                    child: PinCodeTextField(
                                      autofocus: true,
                                      highlight: true,
                                      pinTextStyle:TextStyle(fontFamily: "Cairo-Bold", fontSize:16, color: Theme.of(context).primaryColor),
                                      pinBoxHeight: MediaQuery.of(context).size.height * .08,
                                      pinBoxRadius: 5,
                                      pinBoxWidth: MediaQuery.of(context).size.height * .08,
                                      pinBoxBorderWidth: 1,
                                      errorBorderColor: Colors.red,
                                      pinBoxColor: Colors.grey[100]!,
                                      highlightColor: Theme.of(context).primaryColor,
                                      hasTextBorderColor: Theme.of(context).primaryColor,
                                      pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 5),
                                      defaultBorderColor: Colors.white,
                                      onDone: (on) {
                                        cubit.code = on;
                                      },
                                    ),
                                  ),

                                  //============== اعادة ارسال الكود =================
                                  // FlatButton(
                                  //   onPressed: () {},
                                  //   child: Text(
                                  //     "اعادة ارسال",
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontFamily: 'Cairo-Bold',
                                  //       color: Theme.of(context).accentColor,
                                  //     ),
                                  //   ),
                                  // ),

                                  //==================== تحقق ======================
                                  BlocConsumer<ConfirmCodeCubit, ConfirmCodeState>(
                                    listener: (_, state){
                                      if(state is ConfirmCodeErrorState){
                                        customSnackBar(_, state.error);
                                      }else if (state is ConfirmCodeSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => Sections(skip: false)));
                                        print("============================= تم التاكيد =========================");
                                      }
                                    },

                                    builder: (context, state){
                                      return state is ConfirmCodeLoadingState
                                          ? CenterLoading()
                                          : CustomButton(
                                              text: "التحقق",
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: 40,
                                              onTap: () {
                                                if (formKey.currentState!.validate()) {
                                                  cubit.VerifyCode();
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
