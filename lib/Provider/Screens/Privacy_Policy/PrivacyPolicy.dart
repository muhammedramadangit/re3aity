import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Provider_Notification.dart';
import 'package:lastre3ayty/User/Controller/TermsAndPolicy.dart';
import 'package:lastre3ayty/User/models/TermsAndPolicy.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';

class ProviderPrivacyPolicy extends StatefulWidget {
  final VoidCallback openDrawer;

  const ProviderPrivacyPolicy({Key key, @required this.openDrawer}) : super(key: key);

  @override
  _ProviderPrivacyPolicyState createState() => _ProviderPrivacyPolicyState();
}

class _ProviderPrivacyPolicyState extends State<ProviderPrivacyPolicy> {

  //=======controller and model the same in user========================
  bool isLoading = true;
  TermsAndPolicyController _policyController = TermsAndPolicyController();
  TermsAndPolicyModel _policyModel = TermsAndPolicyModel();

  void _getPolicy() async {
    _policyModel = await _policyController.getTerms();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: "سياسة الخصوصية",
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderNotification())),
          showDrawerIcon: true,
          onPressedDrawer: widget.openDrawer,
        ),

        body: isLoading?
        Center(
          child: SpinKitChasingDots(
            size: 25,
            color: Theme.of(context).primaryColor,
          ),
        ):Padding(
          padding: EdgeInsets.only(top: 25, right: 20, left: 20),
          child: AnimatedWidgets(
            duration: 1.5,
            virticaloffset: 150,
            horizontalOffset: 0,
            child: Text(
              "${_policyModel.data.policy}",
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
