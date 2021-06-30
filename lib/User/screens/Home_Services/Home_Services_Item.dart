import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lastre3ayty/User/screens/Home_Services/HomeServicesDetails/HomeServicesDetails.dart';
import 'package:lastre3ayty/common/CustomCard.dart';

class HomeServiceItem extends StatelessWidget {
  final String name, imgSrc, description;
  final double rate;

  const HomeServiceItem(
      {this.name, this.imgSrc, this.description, this.rate});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeServicesDetails())),
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
                    image: AssetImage(imgSrc),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Padding(
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
                  initialRating: rate,
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
        ],
      ),
    );
  }
}
