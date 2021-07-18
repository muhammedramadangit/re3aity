import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Item.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Items.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_widget.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Main_Page.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Login/ProviderLogin.dart';
import 'package:lastre3ayty/Provider/Screens/Privacy_Policy/PrivacyPolicy.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_Cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Terms_and_Conditions/Terms_and_Conditions.dart';
import 'package:lastre3ayty/User_or_Provider/UserOrProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderMainDrawer extends StatefulWidget {
  final int index;
  final String appBarTitle;
  final ProviderProfileCubit providerProfileCubit;

  ProviderMainDrawer({this.index, this.appBarTitle, this.providerProfileCubit});

  @override
  _ProviderMainDrawerState createState() => _ProviderMainDrawerState();
}

class _ProviderMainDrawerState extends State<ProviderMainDrawer> {
  double xOffset;
  double yOffset;
  double scaleFactor;
  bool isDrawerOpen;
  bool isDragging = false;
  ProviderDrawerItem item;


  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = -150;
      yOffset = 80;
      scaleFactor = 0.8;
      isDrawerOpen = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            buildDrawer(),
            buildPage(),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() => SafeArea(
        child: Container(
          //width: -xOffset,
          child: ProviderDrawerWidget(
            onSelectedItem: (item) async {
              SharedPreferences _pref = await SharedPreferences.getInstance();
              if (item == ProviderDrawerItems.logout) {
                _pref.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => UserOrProvider()),
                    (route) => false);
              } else {
                setState(() => this.item = item);
                closeDrawer();
              }
            },
          ),
        ),
      );

  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;

          const delta = 1;
          if (details.delta.dx < delta) {
            openDrawer();
          } else if (details.delta.dx > -delta) {
            closeDrawer();
          }

          isDragging = false;
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: Container(
                color: isDrawerOpen
                    ? Colors.white12
                    : Theme.of(context).primaryColor,
                child: getDrawerPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Widget getDrawerPage() {
    if (item == ProviderDrawerItems.myReservation) {
      return ProviderMainDrawer(appBarTitle: "حجوزاتي", index: 0);
    } else if (item == ProviderDrawerItems.terms) {
      return ProviderTermsAndConditions(openDrawer: openDrawer);
    } else if (item == ProviderDrawerItems.privacyPolicy) {
      return ProviderPrivacyPolicy(openDrawer: openDrawer);
    } else {
      return MainProviderPage(
        openDrawer: openDrawer,
        index: widget.index,
        appBarTitle: widget.appBarTitle,
        providerProfileCubit: widget.providerProfileCubit,
      );
    }
  }
}
