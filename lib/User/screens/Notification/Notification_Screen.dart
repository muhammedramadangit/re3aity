import 'package:flutter/material.dart';
import 'package:re3aity/User/screens/Notification/Controller/NotificationController.dart';
import 'package:re3aity/User/screens/Notification/Notification_Item.dart';
import 'package:re3aity/User/screens/Notification/model/notification_model.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CenterMessage.dart';
import 'package:re3aity/common/CustomAppBar.dart';

class NotificationPage extends StatefulWidget {
  final bool? skip;

  NotificationPage({this.skip});

  @override
  _NotificationPagesState createState() => _NotificationPagesState();
}

class _NotificationPagesState extends State<NotificationPage> {
  NotificationModel _notificationModel = NotificationModel();
  NotificationController _notificationController = NotificationController();
  bool _isLoading = true;

  void getNotification() async {
    _notificationModel = await _notificationController.getNotification();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: "الاشعارات",
        ),
        body: widget.skip == true
            ? CenterMessage(msg: "لا يوجد اشعارات برجاء تسجيل الدخول أولا")
            : _isLoading
            ? CenterLoading()
            : _notificationModel.data!.length == 0
              ? CenterMessage(msg: "لا يوجد اشعارات")
              : Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _notificationModel.data!.length,
                  itemBuilder: (_, index) {
                    return AnimatedWidgets(
                      duration: 1.5,
                      virticaloffset: 50,
                      horizontalOffset: 0,
                      child: NotificationItem(
                        title: _notificationModel.data![index]!.title,
                        description: _notificationModel.data![index]!.body,
                        time: _notificationModel.data![index]!.updatedAt,
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

// Slidable(
//   actionPane: SlidableBehindActionPane(),
//   actionExtentRatio: 0.25,
//   child: NotificationItem(
//     title: "تم تأكيد الحجز",
//     description: "هذا النص هو مثال لنص يمكن ان يستبدل",
//     time: "02:30 pm",
//   ),
//   secondaryActions: [
//     IconSlideAction(
//       iconWidget: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: Container(
//           height: 70,
//           width: 70,
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: Center(
//             child: Image.asset(
//               "assets/icons/delete.png",
//               height: 40,
//               width: 40,
//               color: Colors.white,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
