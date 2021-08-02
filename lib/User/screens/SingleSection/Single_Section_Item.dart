import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lastre3ayty/User/models/Category_model/Sub_category.dart';
import 'package:lastre3ayty/User/screens/SingleSection/Add_Reservation/Add_Reservation.dart';
import 'package:lastre3ayty/common/CustomCard.dart';

class SingleSectionItem extends StatelessWidget {
  final String name, imgSrc, description, serviceName;
  final int rate, catID, providerID;
  final Subcategory subcategories;
  final bool skip;

  SingleSectionItem({
    this.name,
    this.imgSrc,
    this.description,
    this.rate,
    this.subcategories,
    this.catID,
    this.serviceName,
    this.skip, this.providerID,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddReservation(
                      person: subcategories,
                      catID: catID,
                      serviceName: serviceName,
                      skip: skip,
                  providerID: providerID,
                    )));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            //================ doctor image =================
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

          //================ doctor details ===================
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: rate.toDouble(),
                    itemSize: 20,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    unratedColor: Colors.grey[300],
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) {
                      return Image.asset("assets/icons/starac.png");
                    },
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
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
