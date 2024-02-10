import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? height, width, radius, verticalPadding, horizontalPadding, topPadding, bottomPadding;
  final Color? color;
  final Widget? child;
  final VoidCallback? onTap;

  CustomCard({this.height, this.radius, this.verticalPadding, this.color, this.child, this.onTap, this.horizontalPadding, this.topPadding, this.bottomPadding, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: topPadding ?? 2, bottom: bottomPadding ?? 2),
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
            borderSide: BorderSide.none,
          ),
          elevation: 2,
          color: color ?? Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10, vertical: verticalPadding ?? 8),
            child: child,
          ),
        ),
      ),
    );
  }
}
