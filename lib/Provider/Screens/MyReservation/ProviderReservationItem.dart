import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/common/CustomRichText.dart';
import 'package:lastre3ayty/theme/color.dart';

class ProviderReservationItem extends StatelessWidget {
  final String name, imgSrc, gender, date, time, location,phoneNumber;

  ProviderReservationItem({
    this.name,
    this.imgSrc,
    this.gender,
    this.date,
    this.time,
    this.location,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: MediaQuery.of(context).size.height / 6.2,
      horizontalPadding: 8,
      onTap: () {},
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    //ToDO: add image link
                    image: NetworkImage(imgSrc),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRichText(title: "الأسم", subTitle: name, fontSize: 10),
                      CustomRichText(title: "الجنس", subTitle: gender, fontSize: 10),
                      CustomRichText(title: "رقم الجوال", subTitle: phoneNumber.toString(), fontSize: 10),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRichText(title: "التاريخ", subTitle: date, fontSize: 10),
                      CustomRichText(title: "الوقت", subTitle: time, fontSize: 10),
                      CustomRichText(title: "المكان", subTitle: location, fontSize: 10),
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
