import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Provider_Notification.dart';
import 'package:lastre3ayty/User/Controller/TermsAndPolicy.dart';
import 'package:lastre3ayty/User/models/TermsAndPolicy.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';

class ProviderTermsAndConditions extends StatefulWidget {
  final VoidCallback openDrawer;

  const ProviderTermsAndConditions({Key key, @required this.openDrawer})
      : super(key: key);

  @override
  _ProviderTermsAndConditionsState createState() =>
      _ProviderTermsAndConditionsState();
}

class _ProviderTermsAndConditionsState extends State<ProviderTermsAndConditions> {

  //=======controller and model the same in user========================
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
          onTapNotification: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => ProviderNotification())),
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
