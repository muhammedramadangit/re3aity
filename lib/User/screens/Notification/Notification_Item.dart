import 'package:flutter/material.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/theme/color.dart';

class NotificationItem extends StatelessWidget {
  final String title, time, description;

  const NotificationItem({Key key, this.title, this.time, this.description}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/icons/notification.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    time,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).accentColor,
                    ),
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
