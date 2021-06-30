import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/screens/Doctors/Doctors.dart';
import 'package:lastre3ayty/User/screens/Electricity/Electricity.dart';
import 'package:lastre3ayty/User/screens/Home_Services/Home_Services.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Screen.dart';
import 'package:lastre3ayty/User/screens/Plumbing/Plumbing.dart';
import 'package:lastre3ayty/User/screens/Profile/profile.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';


class SectionPage extends StatefulWidget {
  final VoidCallback openDrawer;
  final int index;
  final String appBarTitle;
  final bool showSearchIcon;

  const SectionPage({Key key, @required this.openDrawer, this.index, this.appBarTitle, this.showSearchIcon = true}) : super(key: key);

  @override
  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  var pages = [];
  int _selectedIndex = 0;

  whichPage() {
    if (widget.index == null) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _selectedIndex = widget.index;
      });
    }
  }

  @override
  void initState() {
    pages = [
      Doctors(),
      HomeServices(),
      Plumbing(),
      Electricity(),
      Profile(),
    ];
    whichPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          appBarTilte: widget.appBarTitle,
          showSearchIcon: widget.showSearchIcon,
          onTapSearchIcon: () {},
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
          showDrawerIcon: true,
          onPressedDrawer: () {
            widget.openDrawer();
          }
      ),
      body: pages[_selectedIndex],
    );
  }
}