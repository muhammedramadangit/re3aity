import 'package:flutter/material.dart';
import 'package:re3aity/Provider/Screens/Auth/Login/ProviderLogin.dart';
import 'package:re3aity/User/screens/Auth/Login/login_screen.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CustomSection.dart';


class UserOrProvider extends StatefulWidget {
  @override
  _UserOrProviderState createState() => _UserOrProviderState();
}

class _UserOrProviderState extends State<UserOrProvider> {
  @override
  Widget build(BuildContext context) {
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
                        height: MediaQuery.of(context).size.height / 3.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/app_logo.png'),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        AnimatedWidgets(
                          duration: 1.5,
                          horizontalOffset: 50,
                          virticaloffset: 0,
                          child: CustomSection(
                            height: 140,
                            width: 140,
                            horizontalPadding: 4,
                            title: "مستخدم",
                            imgSrc: "assets/icons/doc.png",
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                          ),
                        ),

                        AnimatedWidgets(
                          duration: 1.5,
                          horizontalOffset: -50,
                          virticaloffset: 0,
                          child: CustomSection(
                            height: 140,
                            width: 140,
                            horizontalPadding: 4,
                            title: "مقدم خدمة",
                            imgSrc: "assets/icons/provider.png",
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderLogin())),
                          ),
                        ),
                      ],
                    ),

                    // CustomButton(
                    //   height: 45,
                    //   width: MediaQuery.of(context).size.width,
                    //   color: Theme.of(context).primaryColor,
                    //   leftPadding: 15,
                    //   rightPadding: 15,
                    //   topPadding: 15,
                    //   bottomPadding: 10,
                    //   text: "تسجيل كمستخدم",
                    //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                    // ),
                    //
                    // CustomButton(
                    //   height: 45,
                    //   width: MediaQuery.of(context).size.width,
                    //   color: Theme.of(context).primaryColor,
                    //   leftPadding: 15,
                    //   rightPadding: 15,
                    //   topPadding: 5,
                    //   bottomPadding: 15,
                    //   text: "تسجيل كمزود خدمة",
                    //   onTap: () {},
                    // ),

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
