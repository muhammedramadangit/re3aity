import 'package:flutter/material.dart';
import 'package:re3aity/theme/color.dart';

class CustomSectionButton extends StatefulWidget {
  final double? width,
      height,
      opacity,
      radius,
      topPadding,
      bottomPadding,
      rightPadding,
      leftPadding,
      horizontalPadding,
      fontsize, imgSize;
  final String? text, imgSrc;
  final Color? color;
  final bool? rightside;
  final BoxFit? fit;
  final Color? imgColor;

  final Color? textColor;

  final FontWeight? fontWeight;

  final Widget? title;

  final VoidCallback? onTap;

  const CustomSectionButton(
      {Key? key,
        this.width,
        this.height,
        this.text,
        this.opacity,
        this.radius,
        this.topPadding,
        this.bottomPadding,
        this.rightPadding,
        this.leftPadding,
        this.color,
        this.textColor,
        this.fontWeight,
        this.title,
        this.fontsize,
        this.onTap, this.horizontalPadding, this.rightside, this.imgSize, this.imgSrc, this.fit, this.imgColor})
      : super(key: key);

  @override
  _CustomSectionButtonState createState() => _CustomSectionButtonState();
}

class _CustomSectionButtonState extends State<CustomSectionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.bottomPadding ?? 5,
          top: widget.topPadding ?? 5,
          left: widget.leftPadding ?? 15,
          right: widget.rightPadding ?? 15),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.color == ThemeColor.lighterGreyText
                      ? ThemeColor.lighterGreyText.withOpacity(0.5)
                      : widget.color == Colors.white
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(widget.opacity ?? 1),
                  widget.color == ThemeColor.lighterGreyText
                      ? ThemeColor.lighterGreyText.withOpacity(0.2)
                      : widget.color == Colors.white
                      ? Colors.white
                      : Color(0xFFD873CB), // Color(0xFF32c5ff), //Color(0xFFD873CB),
                  widget.color == ThemeColor.lighterGreyText
                      ? ThemeColor.lighterGreyText.withOpacity(0.5)
                      : widget.color == Colors.white
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(widget.opacity ?? 1),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(widget.radius ?? 10)),
          width: widget.width ?? 140,
          height: widget.height ?? 70,
          child: widget.rightside == false ?
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width:50,
                  child: Image.asset(widget.imgSrc ?? "",
                      height: widget.imgSize ?? 50,
                      width: widget.imgSize ?? 50,
                      fit: widget.fit ?? BoxFit.cover,
                      color: widget.color == Colors.white
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.white),
                ),
                Text(
                  widget.text ?? "",
                  style: TextStyle(
                    color: widget.textColor ?? Colors.white,
                    fontSize: widget.fontsize ?? 15,
                    fontWeight: widget.fontWeight ?? FontWeight.bold,
                  ),
                ),
              ],
            ),
          ) : Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text ?? "",
                  style: TextStyle(
                    color: widget.textColor ?? Colors.white,
                    fontSize: widget.fontsize ?? 15,
                    fontWeight: widget.fontWeight ?? FontWeight.bold,
                  ),
                ),

                Container(
                  height: 50,
                  width:50,
                  child: Image.asset(widget.imgSrc ?? "",
                      height: widget.imgSize ?? 50,
                      width: widget.imgSize ?? 50,
                      fit: widget.fit ?? BoxFit.cover,
                      color: widget.color == Colors.white
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.white),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// child: Center(
//   child: widget.text == null
//       ? widget.title
//       : Text(
//     widget.text ?? "",
//     style: TextStyle(
//       color: widget.textColor ?? Colors.white,
//       fontSize: widget.fontsize ?? 15,
//       fontWeight: widget.fontWeight ?? FontWeight.bold,
//     ),
//   ),
// ),