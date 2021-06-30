import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/CustomDrawer/Drawer_Item.dart';
import 'package:lastre3ayty/User/CustomDrawer/Drawer_Items.dart';
import 'package:lastre3ayty/User/CustomDrawer/Drawer_widget.dart';
import 'package:lastre3ayty/User/CustomDrawer/SectionPage.dart';
import 'package:lastre3ayty/User/screens/Auth/Login/login_screen.dart';
import 'package:lastre3ayty/User/screens/Privacy_Policy/PrivacyPolicy.dart';
import 'package:lastre3ayty/User/screens/Sections/Sections.dart';
import 'package:lastre3ayty/User/screens/Terms_and_Conditions/Terms_and_Conditions.dart';
import 'package:lastre3ayty/User/screens/User_Reservation/User_Reservation.dart';

class MainDrawer extends StatefulWidget {
  final int index;
  final String appBarTitle;
  final bool showSearchIcon;

  const MainDrawer({this.index, this.appBarTitle, this.showSearchIcon = true});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  double xOffset;
  double yOffset;
  double scaleFactor;
  bool isDrawerOpen;
  bool isDragging = false;
  DrawerItem item;


  DrawerItems _items = DrawerItems();

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
          child: DrawerWidget(
            onSelectedItem: (item) {
              if (item == DrawerItems.logout) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
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
    if (item == DrawerItems.sections) {
      return Sections(openDrawer: isDrawerOpen== true ? closeDrawer : openDrawer);
    } else if (item == DrawerItems.myReservation) {
      return UserReservation(openDrawer: openDrawer);
    } else if (item == DrawerItems.terms) {
      return TermsAndConditions(openDrawer: openDrawer);
    } else if (item == DrawerItems.privacyPolicy) {
      return PrivacyPolicy(openDrawer: openDrawer);
    } else {
      return SectionPage(openDrawer: openDrawer, appBarTitle: widget.appBarTitle, index: widget.index, showSearchIcon: widget.showSearchIcon,);
    }

    // switch (item) {
    //   case DrawerItems.terms:
    //     return TermsAndConditions();
    //     break;
    //
    //   default:
    //     return PhysicalTherapyDoctors(
    //       openDrawer: openDrawer,
    //     );
    // }
  }
}



