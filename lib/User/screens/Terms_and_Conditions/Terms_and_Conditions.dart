import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/Controller/TermsAndPolicy.dart';
import 'package:lastre3ayty/User/models/TermsAndPolicy.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Screen.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';

class TermsAndConditions extends StatefulWidget {
  final VoidCallback openDrawer;

  const TermsAndConditions({Key key, @required this.openDrawer})
      : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  TermsAndPolicyController _termsController = TermsAndPolicyController();
  TermsAndPolicyModel _termsModel = TermsAndPolicyModel();
  bool isLoading = true;

  void getTerms() async {
    _termsModel = await _termsController.getTerms();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTerms();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: "الشروط والأحكام",
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
          showDrawerIcon: true,
          onPressedDrawer: widget.openDrawer,
        ),

        body: isLoading
            ? CenterLoading()
            : Padding(
                padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                child: AnimatedWidgets(
                  duration: 1.5,
                  virticaloffset: 150,
                  horizontalOffset: 0,
                  child: Text(
                    "${_termsModel.data.condition}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      height: 1.8,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
