import 'dart:async';
import "package:flutter/material.dart";
import 'package:re3aity/common/AnimatedWidget.dart';

class SplashScreen extends StatefulWidget {
  final Widget? screen;

  SplashScreen({this.screen});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => widget.screen!),
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
