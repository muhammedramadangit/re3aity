import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/ProviderReservationItem.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Provider_Notification.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';

class ProviderReservation extends StatefulWidget {
  @override
  _ProviderReservationState createState() => _ProviderReservationState();
}

class _ProviderReservationState extends State<ProviderReservation> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(right: 15, left: 15, top: 10),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) {
              return AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 50,
                horizontalOffset: 0,
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                  actions: [
                    IconSlideAction(
                      iconWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/icons/delete.png",
                              height: 40,
                              width: 40,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      iconWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/done.png",
                                color: Colors.white,
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "إنهاء",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: ProviderReservationItem(
                    imgSrc: "assets/images/doctor.jpg",
                    name: "محمد رمضان",
                    gender: "ذكر",
                    phoneNumber: 1234567890,
                    date: "1/1/2021",
                    time: "08:00 مساءا",
                    location: "العيادة",
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
