import 'package:flutter/material.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterMessage.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/common/CustomRichText.dart';

class EndedReservation extends StatefulWidget {
  @override
  _EndedReservationState createState() => _EndedReservationState();
}

class _EndedReservationState extends State<EndedReservation> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return count == 0
        ? CenterMessage(msg: "لا يوجد حجوزات")
        : ListView.builder(
            itemCount: 0,
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
                      CustomRichText(title: "نوع الخدمة", subTitle: "علاج طبيعي"),
                      CustomRichText(title: "اسم مقدم الخدمة", subTitle: "محمد رمضان"),
                      CustomRichText(title: "المكان", subTitle: "العيادة"),
                      CustomRichText(title: "العنوان", subTitle: "جدة، حي العزيزية، شارع الملك فهد"),
                      CustomRichText(title: "الوقت", subTitle: "12:12"),
                      CustomRichText(title: "التاريخ", subTitle: "30/10/2021"),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
