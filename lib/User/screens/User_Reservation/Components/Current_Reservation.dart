import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/User/Controller/CurrentReservation.dart';
import 'package:lastre3ayty/User/models/CurrentReservation.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterMessage.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/common/CustomRichText.dart';

class CurrentReservation extends StatefulWidget {
  @override
  _CurrentReservationState createState() => _CurrentReservationState();
}

class _CurrentReservationState extends State<CurrentReservation> {
  bool _isLoading = true;
  CurrentModel _currentModel = CurrentModel();
  CurrentController _currentController = CurrentController();

  void currentReservation() async {
    _currentModel = await _currentController.getCurrent();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    currentReservation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: SpinKitChasingDots(
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
          ) : _currentModel.data.length == 0
            ? CenterMessage(msg: "لا يوجد حجوزات")
            : ListView.builder(
                itemCount: _currentModel.data.length,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (_, index) {
                  return AnimatedWidgets(
                    duration: 1.5,
                    horizontalOffset: 0,
                    virticaloffset: 150,
                    child: CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRichText(title: "نوع الخدمة", subTitle:"${_currentModel.data[index].catName}"),
                          CustomRichText(title: "اسم مقدم الخدمة", subTitle: "${_currentModel.data[index].userName}"),
                          CustomRichText(title: "العنوان", subTitle: "${_currentModel.data[index].address}"),
                          CustomRichText(title: "المكان", subTitle: "${_currentModel.data[index].place}"),
                          CustomRichText(title: "الوقت", subTitle: "${_currentModel.data[index].time}"),
                          CustomRichText(title: "التاريخ", subTitle: "${_currentModel.data[index].date}"),
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}
