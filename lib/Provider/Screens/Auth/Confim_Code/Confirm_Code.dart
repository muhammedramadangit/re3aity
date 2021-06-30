import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/Complete_Register.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Confim_Code/Bloc/VerifyCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Confim_Code/Bloc/VerifyState.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ProviderConfirmCode extends StatefulWidget {
  @override
  _ProviderConfirmCodeState createState() => _ProviderConfirmCodeState();
}

class _ProviderConfirmCodeState extends State<ProviderConfirmCode> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = ProviderVerifyCubit.get(context);
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
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                                    child: PinCodeTextField(
                                      autofocus: true,
                                      highlight: true,
                                      pinTextStyle:TextStyle(fontFamily: "Cairo-Bold", fontSize:16, color: Theme.of(context).primaryColor),
                                      pinBoxHeight: MediaQuery.of(context).size.height * .08,
                                      pinBoxRadius: 5,
                                      pinBoxWidth: MediaQuery.of(context).size.height * .08,
                                      pinBoxBorderWidth: 1,
                                      errorBorderColor: Colors.red,
                                      pinBoxColor: Colors.grey[100],
                                      highlightColor: Theme.of(context).primaryColor,
                                      hasTextBorderColor: Theme.of(context).primaryColor,
                                      pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 5),
                                      defaultBorderColor: Colors.white,
                                      onDone: (on) {
                                        cubit.code = on;
                                      },
                                    ),
                                  ),

                                  //=============== اعادة ارسال ==================
                                  FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      "اعادة ارسال",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Cairo-Bold',
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ),

                                  //================= التحقق ===================
                                  BlocConsumer<ProviderVerifyCubit, ProviderVerifyState>(
                                    listener: (_, state){
                                      if(state is ProviderVerifyErrorState){
                                        Scaffold.of(_).showSnackBar(SnackBar(
                                          backgroundColor: Theme.of(_).primaryColor,
                                          content: Text(state.error,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 12),),
                                        ));
                                      }else if(state is ProviderVerifySuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderCompleteRegister()));
                                        print("================= تم تفعيل الحساب بنجاح ====================");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is ProviderVerifyLoadingState ? Center(
                                        child: SpinKitChasingDots(
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ) : CustomButton(
                                        text: "التحقق",
                                        width: MediaQuery.of(context).size.width / 2,
                                        height: 40,
                                        onTap: () {
                                          if(formKey.currentState.validate()){
                                            cubit.postProviderVerifyCode();
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
