import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/Complete_Register.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterCubit.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';

class ProviderGender extends StatefulWidget {
  final String male = "ذكر";
  final String female = "أنثى";

  @override
  _ProviderGenderState createState() => _ProviderGenderState();
}

class _ProviderGenderState extends State<ProviderGender> {
  @override
  Widget build(BuildContext context) {
    final cubit = CompleteRegisterCubit.get(context);
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
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //============ Logo Position ===========
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 7, bottom: 50),
                      child: AnimatedWidgets(
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
                    ),

                    //============ Choose Gender =============
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //=================== male ====================
                          AnimatedWidgets(
                            duration: 1.5,
                            horizontalOffset: 50,
                            virticaloffset: 0,
                            child: CustomButton(
                              height: 120,
                              width: 120,
                              leftPadding: 5,
                              rightPadding: 5,
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/male.png", color: Colors.white, height: 80, width: 80, fit: BoxFit.cover),
                                  Text(
                                    widget.male,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                cubit.sex = widget.male;
                                Navigator.of(context).pop();
                              }
                            ),
                          ),

                          //=================== female ====================
                          AnimatedWidgets(
                            duration: 1.5,
                            horizontalOffset: -50,
                            virticaloffset: 0,
                            child: CustomButton(
                              height: 120,
                              width: 120,
                              leftPadding: 5,
                              rightPadding: 5,
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/female.png", color: Colors.white, height: 80, width: 80, fit: BoxFit.cover),
                                  Text(
                                    widget.female,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                                onTap: () {
                                  cubit.sex = widget.female;
                                  Navigator.of(context).pop();
                                }
                            ),
                          ),
                        ],
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
