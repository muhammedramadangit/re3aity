import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Item.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPagesState createState() => _NotificationPagesState();
}

class _NotificationPagesState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: "الاشعارات",
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (_, index) {
              return AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 50,
                horizontalOffset: 0,
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                  child: NotificationItem(
                    title: "تم تأكيد الحجز",
                    description: "هذا النص هو مثال لنص يمكن ان يستبدل",
                    time: "02:30 pm",
                  ),
                  secondaryActions: [
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
