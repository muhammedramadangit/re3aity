import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/User_or_Provider/UserOrProvider.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDialog extends StatefulWidget {
  final String msg, imgSrc;
  final Function navRoute;

  const CustomDialog({Key key, this.msg, this.navRoute, this.imgSrc}) : super(key: key);

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
                child: widget.imgSrc == ""
                    ? Image.asset("assets/icons/desc.png", color: Colors.white)
                    : Icon(CupertinoIcons.checkmark_alt, size: 60, color: Colors.white),
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

class LoginAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedWidgets(
        duration: 1,
        horizontalOffset: 0.0,
        virticaloffset: 150.0,
        child: CupertinoAlertDialog(
          title: Image.asset("assets/icons/alert.png",color: Theme.of(context).accentColor, height: 80, width: 80),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "برجاء تسجيل الدخول اولا",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontFamily: "Cairo-Bold",
                fontSize: 14,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "إلغاء",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontFamily: "Cairo-Bold",
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => UserOrProvider()),
                    (route) => false);
                pref.setBool("skip", false);
              },
              child: Text(
                "تسجيل دخول",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontFamily: "Cairo-Bold",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// content: Container(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Padding(
//         padding: EdgeInsets.symmetric(vertical: 12),
//         child: Text(
//           "برجاء تسجيل الدخول اولا",
//           style: TextStyle(
//             color: Theme.of(context).accentColor,
//             fontFamily: "Cairo-Bold",
//             fontSize: 14,
//           ),
//         ),
//       ),
//       Divider(),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           TextButton(
//             onPressed: () async {
//               SharedPreferences pref = await SharedPreferences.getInstance();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (_) => UserOrProvider()),
//                   (route) => false);
//               pref.setBool("skip", false);
//             },
//             child: Text(
//               "تسجيل دخول",
//               style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontSize: 14,
//                   fontFamily: "Cairo-Bold"),
//             ),
//           ),
//           Container(
//             width: 1,
//             height: 40,
//             color: Theme.of(context).dividerColor,
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               "إلغاء",
//               style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontSize: 14,
//                   fontFamily: "Cairo-Bold"),
//             ),
//           )
//         ],
//       )
//     ],
//   ),
// ),