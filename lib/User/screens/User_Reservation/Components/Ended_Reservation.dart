import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/screens/User_Reservation/Controller/EndedReservation.dart';
import 'package:lastre3ayty/User/screens/User_Reservation/Model/EndedReservation.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CenterMessage.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/common/CustomRichText.dart';

class EndedReservation extends StatefulWidget {
  @override
  _EndedReservationState createState() => _EndedReservationState();
}

class _EndedReservationState extends State<EndedReservation> {
  EndedModel _endedModel = EndedModel();
  EndedController _endedController = EndedController();
  bool _isLoading = true;

  void getEnded() async {
    _endedModel = await _endedController.getEnded();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getEnded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CenterLoading()
        : _endedModel.data.length == 0
            ? CenterMessage(msg: "لا يوجد حجوزات")
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _endedModel.data.length,
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
                          CustomRichText(title: "نوع الخدمة", subTitle: _endedModel.data[index].catName),
                          CustomRichText(title: "اسم مقدم الخدمة", subTitle: _endedModel.data[index].userName),
                          CustomRichText(title: "المكان", subTitle: _endedModel.data[index].address),
                          CustomRichText(title: "العنوان", subTitle: _endedModel.data[index].place),
                          CustomRichText(title: "الوقت", subTitle: _endedModel.data[index].time),
                          CustomRichText(title: "التاريخ", subTitle: _endedModel.data[index].date),
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}
