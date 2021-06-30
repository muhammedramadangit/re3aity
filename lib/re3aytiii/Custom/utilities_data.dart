import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/re3aytiii/Custom/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: DrawSingleText(
          title: "لا يوجد بيانات",
          textAlign: TextAlign.center,
          color: ScreenUtilities.mainPurple,
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final dynamic error;

  Error(this.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(child: DrawSingleText(title: error.toString())),
    );
  }
}

class ConnectionError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: DrawSingleText(
          title: " فشل الاتصال",
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.15,
          // child: FlareActor(
          //   "assets/flare/internet_loading.flr",
          //   fit: BoxFit.cover,
          //   animation: "loading",
          //   color: ScreenUtilities.mainPurple,
          //   alignment: Alignment.center,
          // ),
        ),
      ),
    );
  }
}

class DrawSingleTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validatorWarning;
  final String hintText;
  final String helperText;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle helperStyle;
  final TextAlign textAlign;
  final IconData icon;
  final TextInputType keyboardType;
  final bool secure;
  final int maxLines;
  final Widget suffixIcon;
  final double iconSize;
  final FocusNode focusNode;
  final Function onSaved;

  DrawSingleTextFormField({
    this.controller,
    this.labelText,
    this.validatorWarning,
    this.hintText,
    this.helperText,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.textAlign,
    this.icon,
    this.keyboardType,
    this.secure,
    this.maxLines,
    this.suffixIcon,
    this.iconSize,
    this.focusNode,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      style: TextStyle(
        color: ScreenUtilities.mainPurple,
      ),
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        isDense: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ScreenUtilities.mainPurple,
            ),
            borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        hintStyle: hintStyle,
        helperText: helperText,
        helperStyle: helperStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: Icon(
          icon,
          size: iconSize,
          color: ScreenUtilities.mainPurple,
        ),
        filled: true,
      ),
      obscureText: secure,
      maxLines: maxLines,
      validator: (value) {
        if (value.isEmpty) {
          return validatorWarning;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}

class DrawSingleText extends StatelessWidget {
  final String title;

//  final String fontFamily;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextStyle textStyle;

  const DrawSingleText(
      {Key key,
        this.title,
//      this.fontFamily,
        this.fontSize,
        this.color,
        this.textAlign,
        this.fontWeight,
        this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Cairo',
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}

// TODO: convert it to stl class
drawToast(BuildContext context, String title, gravity) {
  // return Toast.show(
  //   title,
  //   context,
  //   duration: Toast.LENGTH_LONG,
  //   gravity: gravity,
  //   backgroundColor: ScreenUtilities.mainPurple,
  //   backgroundRadius: 10,
  // );
}

class DrawDivider extends StatelessWidget {
  final BuildContext context;

  DrawDivider(this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: ScreenUtilities.mainPurple,
    );
  }
}

Future<void> saveUser({
  int userID,
  String apiToken,
}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt('user_id', userID);
  sharedPreferences.setString('api_token', apiToken);
}

Widget drawSingleRow({String title, String image, onTap, fontSize}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 8,
    ),
    child: InkWell(
      onTap: onTap,
      child: Card(
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        color: ScreenUtilities.mainPurple,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: DrawSingleText(
                  title: title,
                  color: ScreenUtilities.whiteColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: ExactAssetImage(image),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget drawSingleRowHavingTextColumn({
  String title,
  String description,
  IconData icon,
  iconSize,
  titleFontSize,
  descriptionFontSize,
  color,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              DrawSingleText(
                title: title,
                color: ScreenUtilities.blackTextColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.right,
              ),
              DrawSingleText(
                title: description,
                color: ScreenUtilities.lighterGreyText,
                fontSize: descriptionFontSize,
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ],
    ),
  );
}

Widget drawPageLogo({width, height, image}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      alignment: Alignment.topCenter,
      width: width,
      height: height,
      decoration: BoxDecoration(
          image:
          DecorationImage(image: ExactAssetImage(image), fit: BoxFit.fill)),
    ),
  );
}

Widget noInternetConnectionField() {
  return Container(
    padding: EdgeInsets.all(48),
    height: double.infinity,
    width: double.infinity,
    child: Column(
      children: <Widget>[
        Expanded(
          child: Image(image: ExactAssetImage('assets/icons/offline.png')),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            DrawSingleText(
              title: 'الاتصال بالانترنت مقطوع ولا يوجد بيانات مخزنه لعرضها',
              textAlign: TextAlign.right,
              fontSize: 20,
              color: ScreenUtilities.mainPurple,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: DrawSingleText(
                title: '-:جرب',
                textAlign: TextAlign.right,
                fontSize: 18,
                color: ScreenUtilities.mainPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DrawSingleText(
                    title: 'ايقاف تشغيل وضع الطيران',
                    textAlign: TextAlign.right,
                    fontSize: 16,
                    color: ScreenUtilities.mainPurple,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DrawSingleText(
                    title: 'تشغيل بيانات الهاتف المحمول او شبكه الانترنت',
                    textAlign: TextAlign.right,
                    fontSize: 16,
                    color: ScreenUtilities.mainPurple,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DrawSingleText(
                    title: 'التحقق من الإشاره في منطقتك',
                    textAlign: TextAlign.right,
                    fontSize: 16,
                    color: ScreenUtilities.mainPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

void navigationRoot(page, context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}

Widget drawGradientRaisedButton(title, onPressed, width, fontSize, color) {
  return Container(
    width: width,
    child: RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFC32DD8),
              Color(0xFFE793FC),
              Color(0xFFC633DA),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Container(
          constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          // min sizes for Material buttons
          alignment: Alignment.center,
          child: DrawSingleText(
            title: title,
            textAlign: TextAlign.center,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    ),
  );
}

class FetchDataBody extends StatelessWidget {
  final Stream stream;
  final Widget Function(dynamic data) validChild;

  FetchDataBody({this.stream, this.validChild});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          return validChild(snapShot.data);
        } else if (snapShot.error != null) {
          if (snapShot.error is SocketException)
            return noInternetConnectionField();
          else
            return Error(snapShot.error);
        } else {
          if (snapShot.connectionState == ConnectionState.done)
            return NoData();
          else
            return Loading();
        }
      },
    );
  }
}



class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
