import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';

class CustomDialog extends StatefulWidget {
  final String msg;
  final Function navRoute;

  const CustomDialog({Key key, this.msg, this.navRoute}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), widget.navRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      duration: 1,
      horizontalOffset: 0.0,
      virticaloffset: 150.0,
      child: CupertinoAlertDialog(
        content: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Color(0xFFD873CB),
                    Theme.of(context).primaryColor,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                ),
                child: Icon(CupertinoIcons.checkmark_alt,
                    size: 60, color: Colors.white),
              ),
              SizedBox(height: 25),
              Text(
                widget.msg,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                    fontFamily: "Cairo-Regular",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
