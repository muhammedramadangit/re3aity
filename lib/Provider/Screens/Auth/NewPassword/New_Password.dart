import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Login/ProviderLogin.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/NewPassword/bloc/ProviderNewPassCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/NewPassword/bloc/ProviderNewPassState.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';

class ProviderNewPassword extends StatefulWidget {
  @override
  _ProviderNewPasswordState createState() => _ProviderNewPasswordState();
}

class _ProviderNewPasswordState extends State<ProviderNewPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = ProviderNewPassCubit.get(context);
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
                        height: MediaQuery.of(context).size.height / 2.5,
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

                                  //==================== كلمة المرور الجديدة ==================
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    height: 40,
                                    secureText: true,
                                    label: "كلمة المرور الجديدة",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (val){
                                      if(val.isEmpty){
                                        return "برجاء إدخال كلمة المرور الجديدة";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.new_pass = value;
                                    },
                                  ),

                                  //==================== تاكيد كلمة المرور الجديدة ==================
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    height: 40,
                                    secureText: true,
                                    label: "تأكيد كلمة المرور الجديدة",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (val){
                                      if(val.isEmpty){
                                        return "برجاء إعادة إدخال كلمة المرور الجديدة";
                                      }else if(val != cubit.new_pass){
                                        return "كلمة المرور غير متطابقة";
                                      }
                                    },
                                    onChanged: (value){
                                      cubit.confirm_pass = value;
                                    },
                                  ),

                                  //==================== تعيين ==================
                                  BlocConsumer<ProviderNewPassCubit, ProviderNewPassState>(
                                    listener: (_, state){
                                      if(state is ProviderNewPassErrorState){
                                        Scaffold.of(_).showSnackBar(SnackBar(
                                          backgroundColor: Theme.of(_).primaryColor,
                                          content: Text(state.error,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 12),),
                                        ));
                                      }else if(state is ProviderNewPassSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderLogin()));
                                        print("================= تم تغيير كلمة المرور بنجاح ==================");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is ProviderNewPassLoadingState ? Center(
                                        child: SpinKitChasingDots(
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ) : CustomButton(
                                        text: "تعيين",
                                        width: MediaQuery.of(context).size.width / 2,
                                        height: 40,
                                        onTap: (){
                                          if(formKey.currentState.validate()){
                                            cubit.providerNewPass();
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
