import 'package:flutter/material.dart';
import 'package:lastre3ayty/User_or_Provider/UserOrProvider.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomCard.dart';

Widget loginAlert({BuildContext context, bool skip2}){
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.black.withOpacity(0.5),
    child: AnimatedWidgets(
      duration: 1.5,
      horizontalOffset: 0,
      virticaloffset: 150,
      child: Center(
        child: CustomCard(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 1.3,
          horizontalPadding: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "برجاء تسجيل الدخول اولا",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 10),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => UserOrProvider()), (route) => false);
                      pref.setBool("skip", false);
                      skip2 = pref.getBool("skip");
                      print("asdfgchvjkl;'lkjvhxfgzdxdgjh $skip2");
                    },
                    child: Text(
                      "تسجيل دخول",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontFamily: "Cairo-Bold"),
                    ),
                  ),
                  // VerticalDivider(),
                  Container(
                    width: 1,
                    height: MediaQuery.of(context).size.width/8,
                    color: Theme.of(context).dividerColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "إلغاء",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontFamily: "Cairo-Bold"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}