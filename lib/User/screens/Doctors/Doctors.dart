import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/screens/Doctors/Doctors_Item.dart';
import 'package:lastre3ayty/User/screens/Map_Screen/MapScreen.dart';
import 'package:lastre3ayty/User/screens/Profile/profile.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:unicorndial/unicorndial.dart';

class Doctors extends StatefulWidget {
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,

        floatingActionButton: UnicornDialer(
          hasBackground: false,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add_circle_outline, color: Colors.white, size: 25),
          parentButtonBackground: Theme.of(context).accentColor,
          animationDuration: 1,
          childButtons: [
            UnicornButton(
              currentButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                mini: true,
                child: Image.asset("assets/icons/profile.png", color: Colors.white, height: 20, width: 20, fit: BoxFit.cover),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
                },
              ),
            ),

            UnicornButton(
              currentButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                mini: true,
                child: Image.asset("assets/icons/location.png", color: Colors.white, height: 20, width: 20, fit: BoxFit.cover),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
                },
              ),
            ),

          ],
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(right: 15, left: 15, top: 10),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) {
              return AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 50,
                horizontalOffset: 0,
                child: DoctorsItem(
                  name: "اسم الطبيب",
                  description: "هذا النص هو مثال لنص يمكن ان يستبدل",
                  imgSrc: "assets/images/doctor.jpg",
                  rate: 3,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}