import 'package:flutter/material.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/theme/color.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor.greyText,
          elevation: 3,
          titleSpacing: 0,
          leadingWidth: 40,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: CustomTextField(
              horizontalPadding: 10,
              labelSize: 12,
              leftPadding: 0,
              rightPadding: 0,
              secureText: false,
              hint: "ابحث عن ...",
              inputType: TextInputType.text,
              prefixIcon: Container(
                height: 25,
                width: 25,
                child: Center(
                  child: Image.asset(
                    'assets/icons/search.png',
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          leading:
            InkWell(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 15),
                child: Icon(Icons.arrow_back_ios, size: 25, color: Theme.of(context).primaryColor),
              ),
              onTap: () => Navigator.pop(context),
            ),

        ),
      ),
    );
  }
}
