import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Provider_Notification_Item.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';


class ProviderNotification extends StatefulWidget {
  @override
  _ProviderNotificationState createState() => _ProviderNotificationState();
}

class _ProviderNotificationState extends State<ProviderNotification> {

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
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (_, index) {
              return AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 50,
                horizontalOffset: 0,
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                  child: ProviderNotificationItem(
                    title: "إيصال شهر يناير",
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
