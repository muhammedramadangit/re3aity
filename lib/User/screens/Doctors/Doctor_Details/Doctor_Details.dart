import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lastre3ayty/User/models/Category_model/Sub_category.dart';
import 'package:lastre3ayty/User/screens/Doctors/Bloc/AddReservationCubit.dart';
import 'package:lastre3ayty/User/screens/Doctors/Bloc/AddReservationState.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Screen.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/common/CustomDialog.dart';
import 'package:lastre3ayty/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetails extends StatefulWidget {
  final Subcategory person;
  final String serviceName;
  final int catID;

  const DoctorDetails({this.person, this.serviceName, this.catID,});

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool _clinicChecked = true;
  bool _homeChecked = false;
  DateTime _pickedDate;
  TimeOfDay _time;
  List place = ["العيادة", "المنزل"];
  int userID;


  Future<void> shared() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setInt("cat_id", widget.catID);
  }
  @override
  void initState() {
    super.initState();
    shared();
    _pickedDate = DateTime.now();
    _time = TimeOfDay.now();
  }

  // _pickDate() async {
  //   final cubit = AddReservationCubit.get(context);
  //   DateTime date = await showDatePicker(
  //     context: context,
  //     initialDate: _pickedDate,
  //     firstDate: DateTime(DateTime.now().year),
  //     lastDate: DateTime(DateTime.now().year + 1),
  //   );
  //   if (date != null) {
  //     cubit.date = date.toString();
  //     setState(() {
  //       _pickedDate = date;
  //     });
  //   }
  // }

  // _pickTime() async {
  //   final cubit = AddReservationCubit.get(context);
  //   TimeOfDay time = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (time != null) {
  //     cubit.time = time.toString();
  //     setState(() {
  //       _time = time;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("id============. ${widget.catID}");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: widget.person.user.name,
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
        ),

        body: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                doctorInformation(context),

                doctorDescription(context),

                doctorService(context),

                serviceLocation(context),

                dateAndTime(context),

                // Expanded(
                //   child: Container()
                // ),

                reservationButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //=================================== doctor Information =========================================
  Widget doctorInformation(BuildContext context){
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        child: Row(
          children: [
            //=================== provider image ==================
            Container(
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.width / 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://mycare.pro/public/dash/assets/img/${widget.person.user.image}"),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),

            //================ provider address and rate ===============
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.person.user.address,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Cairo-Bold",
                        color: Theme.of(context).accentColor,
                      ),
                    ),

                    RatingBar.builder(
                      initialRating: widget.person.user.rate.toDouble(),
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
            ),
          ],
        ),
      ),
    );
  }

  //==================================== Service Location ==========================================
  Widget serviceLocation(BuildContext context){
    final cubit = AddReservationCubit.get(context);
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "مكان الخدمة",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo-Bold",
                color: Theme.of(context).accentColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //============== العيادة ===============
                  CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: place[0],
                    bottomPadding: 0,
                    topPadding: 0,
                    rightPadding: 0,
                    leftPadding: 2,
                    textColor: _clinicChecked == true
                        ? Colors.white
                        : Theme.of(context).accentColor,
                    color: _clinicChecked == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                    onTap: () {
                      print(place[0]);
                      setState(() {
                        _clinicChecked = true;
                        _homeChecked = false;
                        cubit.place = place[0];
                      });
                    },
                  ),

                  //============== المنزل ===============
                  CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: place[1],
                    bottomPadding: 0,
                    topPadding: 0,
                    rightPadding: 2,
                    leftPadding: 0,
                    textColor: _homeChecked == true
                        ? Colors.white
                        : Theme.of(context).accentColor,
                    color: _homeChecked == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                    onTap: () {
                      print(place[1]);
                      setState(() {
                        _homeChecked = true;
                        _clinicChecked = false;
                        cubit.place = place[1];
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //====================================== Date & Time =============================================
  Widget dateAndTime(BuildContext context){
    final cubit = AddReservationCubit.get(context);
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              height: 40,
              bottomPadding: 10,
              topPadding: 10,
              rightPadding: 0,
              leftPadding: 0,
              horizontalPadding: 8,
              width: MediaQuery.of(context).size.width,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white),
                  Text(
                    "${_pickedDate.day} / ${_pickedDate.month} / ${_pickedDate.year}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
              onTap: () async {
                DateTime date = await showDatePicker(
                  context: context,
                  initialDate: _pickedDate,
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (date != null) {
                  cubit.date = date.toString();
                  setState(() {
                    _pickedDate = date;
                  });
                }
              },
            ),

            CustomButton(
              height: 40,
              bottomPadding: 10,
              topPadding: 10,
              rightPadding: 0,
              leftPadding: 0,
              horizontalPadding: 8,
              width: MediaQuery.of(context).size.width,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white),
                  Text(
                    "${_time.hour} : ${_time.minute}",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
              onTap: () async {
                TimeOfDay time = await showTimePicker(
                  context: context,
                  initialTime: _time,
                );
                if (time != null) {
                  cubit.time = time.format(context);
                  setState(() {
                    _time = time;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  //=================================== Doctor Description =========================================
  Widget doctorDescription(BuildContext context){
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "نبذة عن الطبيب",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo-Bold",
                color: Theme
                    .of(context)
                    .accentColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.person.user.desc,
              style: TextStyle(
                fontSize: 10,
                color: ThemeColor.darkerGreyText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //===================================== doctor Service ===========================================
  Widget doctorService(BuildContext context){
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الخدمات : ${widget.serviceName}",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo-Bold",
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(height: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      "سعر الخدمة فى المنزل : ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      "${widget.person.homeprice.toString()} ريال",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "سعر الخدمة فى العيادة : ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      "${widget.person.clincprice.toString()} ريال",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //=================================== Reservation Button ==========================================
  Widget reservationButton(BuildContext context){
    final cubit = AddReservationCubit.get(context);
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: BlocConsumer<AddReservationCubit, AddReservationState>(
        listener: (_, state){
          if(state is AddReservationErrorState){
            Scaffold.of(_).showSnackBar(SnackBar(
              backgroundColor: Theme.of(_).primaryColor,
              content: Text(state.error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),),
            ));
          }else if(state is AddReservationSuccessState){
            // Navigator.of(_).pop();
            showDialog(context: _, builder: (_){
              return CustomDialog(msg: "تم الحجز بنجاح", navRoute: ()=> Navigator.pop(_));
            });
          }
        },
        builder: (context, state){
          return state is AddReservationLoadingState
              ? CenterLoading()
              : CustomButton(
            height: 45,
            width: MediaQuery.of(context).size.width,
            text: "حجز",
            bottomPadding: 10,
            topPadding: 10,
            rightPadding: 0,
            leftPadding: 0,
            onTap: (){
              cubit.postAddReservation();
            },
          );
        },
      ),
    );
  }
}
