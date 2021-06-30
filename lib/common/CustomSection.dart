import 'package:flutter/material.dart';
import 'package:lastre3ayty/common/CustomButton.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final String imgSrc;
  final Function onTap;
  final double height, width, imgSize, horizontalPadding, verticalPadding;
  final Widget widget;
  final Color color;
  final double fontSize;

  const CustomSection({this.title, this.imgSrc, this.onTap, this.height, this.width, this.horizontalPadding, this.verticalPadding, this.widget, this.color, this.imgSize, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomButton(
        height: height ?? 120,
        width: width ?? 120,
        leftPadding: horizontalPadding ?? 0,
        rightPadding: horizontalPadding ?? 0,
        topPadding: verticalPadding ?? 0,
        bottomPadding: verticalPadding ?? 0,
        color: color ?? Theme.of(context).primaryColor,
        title: widget ?? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgSrc,
                height: imgSize ?? 80, width: imgSize ?? 80, fit: BoxFit.cover, color: color == Colors.white ? Theme.of(context).accentColor : Colors.white),
            SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize ?? 15,
                color: color == Colors.white ? Theme.of(context).accentColor : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
