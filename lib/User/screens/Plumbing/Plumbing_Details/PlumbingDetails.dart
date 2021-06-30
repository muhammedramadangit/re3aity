import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Screen.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/theme/color.dart';

class PlumbingDetails extends StatefulWidget {
  @override
  _PlumbingDetailsState createState() => _PlumbingDetailsState();
}

class _PlumbingDetailsState extends State<PlumbingDetails> {
  bool _isChecked = true;
  DateTime _pickedDate;
  TimeOfDay _time;

  @override
  void initState() {
    super.initState();
    _pickedDate = DateTime.now();
    _time = TimeOfDay.now();
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if(date != null){
      setState(() {
        _pickedDate = date;
      });
    }
  }

  _pickTime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if(time != null){
      setState(() {
        _time = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: "التفاصيل",
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),

              //============ address ================
              AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 0,
                horizontalOffset: 50,
                child: CustomCard(
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 5,
                        width: MediaQuery.of(context).size.width / 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/plumbler.jpg"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "جدة، حي العزيزية، شارع الملك فهد",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Cairo-Bold",
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              itemSize: 20,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              unratedColor: Colors.grey[300],
                              itemCount: 5,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 1),
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
                ),
              ),

              //============ doctor information ================
              AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 0,
                horizontalOffset: 50,
                child: CustomCard(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "نبذة عن مقدم الخدمة",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Cairo-Bold",
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "هذا النص هو مثال لنصيمكن ان يستبدل فى نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي، حيث يمكنك ان تولد مثل هذا النص أو العديد من النصوص الاخرى",
                        style: TextStyle(
                          fontSize: 10,
                          color: ThemeColor.darkerGreyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //============ doctor Service ================
              AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 0,
                horizontalOffset: 50,
                child: CustomCard(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الخدمات",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Cairo-Bold",
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "هذا النص هو مثال لنصيمكن ان يستبدل فى نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي، حيث يمكنك ان تولد مثل هذا النص أو العديد من النصوص الاخرى",
                        style: TextStyle(
                          fontSize: 10,
                          color: ThemeColor.darkerGreyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //============ Service location ================
              // AnimatedWidgets(
              //   duration: 1.5,
              //   virticaloffset: 0,
              //   horizontalOffset: 50,
              //   child: CustomCard(
              //     height: MediaQuery.of(context).size.height / 5,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "مكان الخدمة",
              //           style: TextStyle(
              //             fontSize: 12,
              //             fontFamily: "Cairo-Bold",
              //             color: Theme.of(context).accentColor,
              //           ),
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             CustomButton(
              //               height: 40,
              //               width: MediaQuery.of(context).size.width / 2.5,
              //               text: "العيادة",
              //               bottomPadding: 0,
              //               topPadding: 0,
              //               rightPadding: 0,
              //               leftPadding: 2,
              //               textColor: _isChecked == true ? Colors.white : Theme.of(context).accentColor,
              //               color: _isChecked == true ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
              //               onTap: () {
              //                 print("العيادة");
              //                 setState(() {
              //                   _isChecked =! _isChecked;
              //                 });
              //               },
              //             ),
              //             CustomButton(
              //               height: 40,
              //               width: MediaQuery.of(context).size.width / 2.5,
              //               text: "المنزل",
              //               bottomPadding: 0,
              //               topPadding: 0,
              //               rightPadding: 2,
              //               leftPadding: 0,
              //               textColor: _isChecked == true ? Theme.of(context).accentColor : Colors.white,
              //               color: _isChecked == true ? Theme.of(context).accentColor :  Theme.of(context).primaryColor,
              //               onTap: () {
              //                 print("المنزل");
              //                 setState(() {
              //                   _isChecked =! _isChecked;
              //                 });
              //               },
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              //============ Date and time ================
              AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 0,
                horizontalOffset: 50,
                child: CustomCard(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        height: 40,
                        bottomPadding: 5,
                        topPadding: 5,
                        rightPadding: 0,
                        leftPadding: 0,
                        horizontalPadding: 8,
                        width: MediaQuery.of(context).size.width,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            Text(
                              "${_pickedDate.day} / ${_pickedDate.month} / ${_pickedDate.year}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ],
                        ),
                        onTap: _pickDate,
                      ),

                      CustomButton(
                        height: 40,
                        bottomPadding: 5,
                        topPadding: 5,
                        rightPadding: 0,
                        leftPadding: 0,
                        horizontalPadding: 8,
                        width: MediaQuery.of(context).size.width,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            Text(
                              "${_time.hour} : ${_time.minute}",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ],
                        ),
                        onTap: _pickTime,
                      ),

                    ],
                  ),
                ),
              ),

              Expanded(child: Container()),

              //============ 7gzz button ================
              AnimatedWidgets(
                duration: 1.5,
                virticaloffset: 0,
                horizontalOffset: 50,
                child: CustomButton(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  text: "حجز",
                  bottomPadding: 8,
                  topPadding: 8,
                  rightPadding: 8,
                  leftPadding: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
