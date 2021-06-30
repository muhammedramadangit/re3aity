import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/ConfirmForgetPassword/ConfirmForgetPassword.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Forget_Password/Bloc/Cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Forget_Password/Bloc/State.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/SignUp/Bloc/cubit.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';

class ProviderForgetPassword extends StatefulWidget {
  @override
  _ProviderForgetPasswordState createState() => _ProviderForgetPasswordState();
}

class _ProviderForgetPasswordState extends State<ProviderForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = ProviderForgetCubit.get(context);
    final registerCubit = ProviderSignUpCubit.get(context);
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
                                    'الرجاء ادخال رقم الجوال',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  //========================= رقم الجوال ========================
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 30,
                                    secureText: false,
                                    label: "رقم الجوال",
                                    inputType: TextInputType.phone,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/phone.png"),
                                    suffixIcon: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Divider(),
                                        Text("+966", textDirection: TextDirection.ltr, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                                      ],
                                    ),
                                    validate: (val) {
                                      if(val.isEmpty){
                                        return "برجاء إدخال رقم الجوال";
                                      }else if(val.length > 9 && val.length < 9){
                                        return "يشترط رقم الجوال 9 ارقام";
                                      }
                                    },
                                  ),

                                  // ======================= ارسال ========================
                                  BlocConsumer<ProviderForgetCubit, ProviderForgetStat>(
                                    listener: (_, state){
                                      if(state is ProviderForgetErrorState){
                                        Scaffold.of(_).showSnackBar(SnackBar(
                                          backgroundColor: Theme.of(_).primaryColor,
                                          content: Text(state.error,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 12),),
                                        ));
                                      }else if(state is ProviderForgetSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderConfirmForgetPass()));
                                        print("<<<<<<<<<<<<<<<<<<<<<< تم التاكيد من الرقم >>>>>>>>>>>>>>>>>>>>>>>");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is ProviderForgetLoadingState ? Center(
                                        child: SpinKitChasingDots(
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ) :
                                      CustomButton(
                                        text: "ارسال",
                                        width: MediaQuery.of(context).size.width / 2,
                                        height: 40,
                                        onTap: () {
                                          if(formKey.currentState.validate()){
                                            return cubit.postProviderForget();
                                          }
                                        }
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
