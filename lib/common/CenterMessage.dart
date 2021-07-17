import 'package:flutter/material.dart';

class CenterMessage extends StatelessWidget {
  final String msg;
  CenterMessage({@required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
      ),
    );
  }
}
