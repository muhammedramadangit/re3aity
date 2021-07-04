import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/ProviderReservationItem.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/controller/controller.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/model/model.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Provider_Notification.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';

class ProviderReservation extends StatefulWidget {
  @override
  _ProviderReservationState createState() => _ProviderReservationState();
}

class _ProviderReservationState extends State<ProviderReservation> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  ReversationsModel _reversationsModel = ReversationsModel();
  ReservationController _reservationController =ReservationController() ;
  void _getReservation ()async {
    _reversationsModel = await _reservationController.getReservation();
    setState(() {
      _isLoading = false;
    });
  }


  @override
  void initState() {
    _getReservation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        body:_isLoading ? Center(
          child: SpinKitChasingDots(
            size: 25,
            color: Theme.of(context).primaryColor,
          ),
        ) : _reversationsModel.data==null ? Center(
          child: Text("لا يوجد حجوزات",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
              ),
          ),
        ) : Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(right: 15, left: 15, top: 10),
          child: ListView.builder(
            itemCount: _reversationsModel.data.length,
            itemBuilder: (_, index) {
              return AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 50,
                horizontalOffset: 0,
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                  actions: [
                    IconSlideAction(
                      iconWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/icons/delete.png",
                              height: 40,
                              width: 40,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      iconWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/done.png",
                                color: Colors.white,
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "إنهاء",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: ProviderReservationItem(
                    imgSrc:_reversationsModel.data[index].image,
                    name: _reversationsModel.data[index].userName,
                    gender: _reversationsModel.data[index].sex,
                    phoneNumber: _reversationsModel.data[index].phone,
                    date: _reversationsModel.data[index].date,
                    time: _reversationsModel.data[index].time,
                    location: _reversationsModel.data[index].place,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
