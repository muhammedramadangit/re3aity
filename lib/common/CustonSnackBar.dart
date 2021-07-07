import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customSnackBar(
  BuildContext context,
  String error,
) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    content: Text(
      error,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 12),
    ),
  ));
}