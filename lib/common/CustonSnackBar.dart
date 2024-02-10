import 'package:flutter/material.dart';


void customSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      backgroundColor: Colors.red,
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontFamily: "cairo",
        ),
      ),
    ),
  );
}