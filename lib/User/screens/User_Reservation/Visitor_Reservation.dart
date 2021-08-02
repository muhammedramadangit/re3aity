import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Screen.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomDialog.dart';

class VisitorReservation extends StatefulWidget {
  final VoidCallback openDrawer;

  VisitorReservation({@required this.openDrawer});

  @override
  _VisitorReservationState createState() => _VisitorReservationState();
}

class _VisitorReservationState extends State<VisitorReservation> {
  bool skip2;
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mainPage(context),
        LoginAlertDialog(),
      ],
    );
  }

  //============================== main Page ===================================
  Widget mainPage(BuildContext context){
    return Stack(
      children: [
        Scaffold(
          appBar: customAppBar(
            context: context,
            appBarTilte: "حجوزاتي",
            showNotificationIcon: true,
            onTapNotification: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => NotificationPage())),
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
                          : Theme.of(context).accentColor,
                      color: _isChecked == true
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
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
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      color: _isChecked == true
                          ? Theme.of(context).accentColor
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

              // Expanded(
              //   child: _isChecked == true ? CurrentReservation() : EndedReservation(),
              // ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        )
      ],
    );
  }
}

