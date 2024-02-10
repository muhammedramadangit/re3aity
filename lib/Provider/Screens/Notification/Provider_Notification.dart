import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:re3aity/Provider/Screens/Notification/Controller/ProviderNotifiController.dart';
import 'package:re3aity/Provider/Screens/Notification/Model/ProviderNotifiModel.dart';
import 'package:re3aity/Provider/Screens/Notification/Provider_Notification_Item.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CenterMessage.dart';
import 'package:re3aity/common/CustomAppBar.dart';

class ProviderNotification extends StatefulWidget {
  @override
  _ProviderNotificationState createState() => _ProviderNotificationState();
}

class _ProviderNotificationState extends State<ProviderNotification> {
  ProviderNotificationModel _notificationModel = ProviderNotificationModel();
  ProviderNotificationController _notificationController =
      ProviderNotificationController();
  bool _isLoading = true;

  void getNotification() async {
    _notificationModel = await _notificationController.getProNotification();
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
        body: _isLoading
            ? CenterLoading()
            : _notificationModel.data!.length == 0
                ? CenterMessage(msg: "ليس لديك اشعارات")
                : Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: ListView.builder(
                      itemCount: _notificationModel.data!.length,
                      itemBuilder: (_, index) {
                        return AnimatedWidgets(
                          duration: 1.5,
                          virticaloffset: 50,
                          horizontalOffset: 0,
                          child: ProviderNotificationItem(
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
//   child: ProviderNotificationItem(
//     title: "تلقيت حجز جديد",
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
