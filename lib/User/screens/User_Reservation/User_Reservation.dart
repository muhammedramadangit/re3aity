import 'package:flutter/material.dart';
import 'package:re3aity/User/screens/Notification/Notification_Screen.dart';
import 'package:re3aity/User/screens/User_Reservation/Components/Current_Reservation.dart';
import 'package:re3aity/User/screens/User_Reservation/Components/Ended_Reservation.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CustomAppBar.dart';
import 'package:re3aity/common/CustomButton.dart';

class UserReservation extends StatefulWidget {
  final VoidCallback? openDrawer;
  const UserReservation({Key? key, @required this.openDrawer}) : super(key: key);

  @override
  _UserReservationState createState() => _UserReservationState();
}

class _UserReservationState extends State<UserReservation> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: "حجوزاتي",
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
          showDrawerIcon: true,
          onPressedDrawer: widget.openDrawer,
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedWidgets(
              duration: 1.5,
              horizontalOffset: 0,
              virticaloffset: -50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: "الحالية",
                    bottomPadding: 10,
                    topPadding: 10,
                    rightPadding: 0,
                    leftPadding: 2,
                    textColor: _isChecked == true
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                    color: _isChecked == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
                    onTap: () {
                      print("الحالية");
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                  ),

                  CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: "المنتهية",
                    bottomPadding: 10,
                    topPadding: 10,
                    rightPadding: 2,
                    leftPadding: 0,
                    textColor: _isChecked == true
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.white,
                    color: _isChecked == true
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).primaryColor,
                    onTap: () {
                      print("المنتهية");
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: _isChecked == true ? CurrentReservation() : EndedReservation(),
            ),
          ],
        ),
      ),
    );
  }
}
