import 'dart:async';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:lastre3ayty/User/screens/Sections/Sections.dart';
import 'package:lastre3ayty/User_or_Provider/UserOrProvider.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget screen;

  void checkLogin() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String login = _pref.getString("api_token");
    String admin = _pref.getString("admin");
    if(login == null){
      screen = UserOrProvider();
    }else if(login != null && admin == "user"){
      screen = Sections();
    }else if(login != null && admin == "advertiser"){
      screen = ProviderMainDrawer(appBarTitle: "حجوزاتي", index: 0);
    }
  }

  @override
  void initState() {
    checkLogin();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => screen),
            (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.fill,
            )),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedWidgets(
              duration: 2,
              horizontalOffset: 0,
              virticaloffset: 150,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/app_logo.png'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
