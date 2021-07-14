import 'package:flutter/material.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/common/CustomRichText.dart';

class ProviderReservationItem extends StatelessWidget {
  final String name, imgSrc, gender, date, time, location,phone;

  ProviderReservationItem({
    this.name,
    this.imgSrc,
    this.gender,
    this.date,
    this.time,
    this.location,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      horizontalPadding: 10,
      onTap: () {},
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("https://mycare.pro/public/dash/assets/img/${imgSrc}"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width / 5,
              padding: EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRichText(title: "الأسم", subTitle: name, fontSize: 9),
                      CustomRichText(title: "الجنس", subTitle: gender, fontSize: 9),
                      CustomRichText(title: "رقم الجوال", subTitle: phone, fontSize: 9),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRichText(title: "التاريخ", subTitle: date, fontSize: 9),
                      CustomRichText(title: "الوقت", subTitle: time, fontSize: 9),
                      CustomRichText(title: "المكان", subTitle: location, fontSize: 9),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
