import 'package:flutter/material.dart';
import 'package:lastre3ayty/theme/color.dart';

Widget customRegisterIcon({
  double containerHeight,
  double containerWidth,
  double imageHeight,
  double imageWidth,
  String imgSrc,
  Color color,
}) {
  return Container(
    height: containerHeight ?? 22,
    width: containerWidth ?? 22,
    child: Center(
      child: Image.asset(
        imgSrc,
        height: imageHeight ?? 22,
        width: imageWidth ?? 22,
        fit: BoxFit.cover,
        color: color ?? ThemeColor.mainPurple,
      ),
    ),
  );
}