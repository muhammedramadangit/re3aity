import 'package:flutter/material.dart';
import 'package:re3aity/common/CustomCard.dart';
import 'package:re3aity/common/CustomRichText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderReservationItem extends StatefulWidget {
  final String? name, imgSrc, gender, date, time, location,phone;
  final int? resID;

  ProviderReservationItem({
    this.name,
    this.imgSrc,
    this.gender,
    this.date,
    this.time,
    this.location,
    this.phone, this.resID,
  });

  @override
  _ProviderReservationItemState createState() => _ProviderReservationItemState();
}

class _ProviderReservationItemState extends State<ProviderReservationItem> {

  void sharedResID() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setInt("reservation_id", widget.resID!);
  }

  @override
  void initState() {
    sharedResID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      horizontalPadding: 5,
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
                    image: NetworkImage("https://my-care.life/public/dash/assets/img/${widget.imgSrc}"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width / 5,
              padding: EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRichText(title: "الأسم", subTitle: widget.name, fontSize: 9),
                      CustomRichText(title: "الجنس", subTitle: widget.gender, fontSize: 9),
                      CustomRichText(title: "رقم الجوال", subTitle: widget.phone, fontSize: 9),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRichText(title: "التاريخ", subTitle: widget.date, fontSize: 9),
                      CustomRichText(title: "الوقت", subTitle: widget.time, fontSize: 9),
                      CustomRichText(title: "المكان", subTitle: widget.location, fontSize: 9),
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
