import 'package:flutter/material.dart';
import 'package:re3aity/theme/color.dart';

class CustomTextFieldTap extends StatelessWidget {
  final String? lable;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  // final Function validate;
  final Widget? icon;
  final double? horizontalPadding, verticalPadding, height;

  const CustomTextFieldTap(
      {this.lable,
      this.prefixIcon,
      this.onTap,
      this.icon,
      this.horizontalPadding,
      this.verticalPadding,
      this.height,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 45,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15, vertical: verticalPadding ?? 3),
        padding: EdgeInsets.only(right: 12.0, top: 10.0, bottom: 10.0, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    child: prefixIcon,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        lable ?? "",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeColor.lighterGreyText,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            icon ?? Icon(Icons.arrow_forward_ios,
                size: 18, color: ThemeColor.lighterGreyText),
          ],
        ),
      ),
    );
  }
}
