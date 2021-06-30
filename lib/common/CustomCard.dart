import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double height, radius, verticalPadding, horizontalPadding, topPadding, bottomPadding;
  final Color color;
  final Widget child;
  final Function onTap;

  CustomCard({this.height, this.radius, this.verticalPadding, this.color, this.child, this.onTap, this.horizontalPadding, this.topPadding, this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        margin: EdgeInsets.only(top: topPadding ?? 2, bottom: bottomPadding ?? 2),
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
            borderSide: BorderSide.none,
          ),
          elevation: 2,
          color: color ?? Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: child,
          ),
        ),
      ),
    );
  }
}
