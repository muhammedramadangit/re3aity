import 'package:flutter/material.dart';
import 'package:lastre3ayty/theme/color.dart';

class CustomTextField extends StatelessWidget {
  final Function onChanged;
  final Function validate;
  final Function onTab;
  final Function onSubmitted;
  final Function onSaved;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final double width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double leftPadding;
  final double rightPadding;

  final TextInputType inputType;
  final String label;
  final String hint;
  final int lines;
  final double labelSize;
  final bool secureText;
  final double radius;

//  final String initialText;
  final bool isEnabled;
  final Color color;

  final hintColor;

  final TextEditingController controller;

  const CustomTextField({
    Key key,
    this.onChanged,
    this.validate,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.inputType,
    this.label,
    this.hint,
    this.lines,
    this.labelSize,
    this.secureText,
    this.radius,
    this.onTab,
    this.onSubmitted,
    this.isEnabled = true,
    this.controller,
    this.horizontalPadding,
    this.verticalPadding,
    this.rightPadding,
    this.leftPadding,
    this.color,
    this.hintColor, this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 5, horizontal: horizontalPadding ?? 5),
      child: Container(
        width: width,
        margin: EdgeInsets.only(
            left: leftPadding, right: rightPadding, top: 2.0, bottom: 2.0),
        height: height,
        child: TextFormField(
            controller: controller != null ? controller : null,
            onFieldSubmitted: onSubmitted,
            onTap: onTab,
            maxLines: lines ?? 1,
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 11.0),
            obscureText: secureText ?? false,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: inputType ?? TextInputType.multiline,
            validator: validate,
            onSaved: onSaved,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              errorStyle: TextStyle(
                fontSize: 10,
              ),
              errorMaxLines: 4,
              contentPadding: EdgeInsets.only(
                  right: 20.0, top: 10.0, bottom: 10.0, left: 20),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(radius ?? 10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              filled: true,
              fillColor: color ?? Colors.grey[100],
              prefixIcon: prefixIcon ?? null,
              suffixIcon: suffixIcon ?? null,
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 20, maxWidth: 40),
              labelText: label,
              labelStyle: TextStyle(
                fontSize: labelSize,
                color: Theme.of(context).accentColor,
              ),
              hintStyle: TextStyle(fontSize: 12, color: hintColor ?? Theme.of(context).accentColor),
              hintText: hint,
            ),
            onChanged: onChanged),
      ),
    );
  }
}
