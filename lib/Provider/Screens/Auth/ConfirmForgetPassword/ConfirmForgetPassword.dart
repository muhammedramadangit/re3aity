import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/ConfirmForgetPassword/Bloc/ProviderConfirmForgetCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/ConfirmForgetPassword/Bloc/ProviderConfirmForgetState.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/NewPassword/New_Password.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ProviderConfirmForgetPass extends StatefulWidget {
  @override
  _ProviderConfirmForgetPassState createState() => _ProviderConfirmForgetPassState();
}

class _ProviderConfirmForgetPassState extends State<ProviderConfirmForgetPass> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = ProviderConfirmForgetCubit.get(context);
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
                                  BlocConsumer<ProviderConfirmForgetCubit, ProviderConfirmForgetState>(
                                    listener: (_, state){
                                      if(state is ProviderConfirmForgetErrorState){
                                        Scaffold.of(_).showSnackBar(SnackBar(
                                          backgroundColor: Theme.of(_).primaryColor,
                                          content: Text(state.error,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 12),),
                                        ));
                                      }else if(state is ProviderConfirmForgetSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderNewPassword()));
                                        print("<<<<<<<<<<<<<<<<<<<<< تم التحقق من الرقم بنجاح >>>>>>>>>>>>>>>>>>>>>");
                                      }
                                    },
                                    builder: (context, state){
                                      return state is ProviderConfirmForgetLoadingState ? Center(
                                        child: SpinKitChasingDots(
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ) : CustomButton(
                                          text: "التحقق",
                                          width: MediaQuery.of(context).size.width / 2,
                                          height: 40,
                                          onTap: () {
                                            if(cubit.code == null && cubit.code.length < 4){
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                backgroundColor: Theme.of(context).primaryColor,
                                                content: Text("برجاء ادخال الكود",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white, fontSize: 12),),
                                              ));
                                            }else{
                                              cubit.providerConfirmForget();
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
