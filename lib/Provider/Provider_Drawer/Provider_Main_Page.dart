import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/ProviderReservation.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Provider_Notification.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Provider_Profile.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';


class MainProviderPage extends StatefulWidget {
  final VoidCallback openDrawer;
  final int index;
  final String appBarTitle;

  MainProviderPage({@required this.openDrawer, this.index, this.appBarTitle});

  @override
  _MainProviderPageState createState() => _MainProviderPageState();
}

class _MainProviderPageState extends State<MainProviderPage> {
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
      ProviderReservation(),
      ProviderProfile(),
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
        showNotificationIcon: true,
        onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderNotification())),
        showDrawerIcon: true,
        onPressedDrawer: widget.openDrawer,
      ),
      body: pages[_selectedIndex],
    );
  }
}