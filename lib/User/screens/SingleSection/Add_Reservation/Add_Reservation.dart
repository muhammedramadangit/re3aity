import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:re3aity/User/models/Category_model/Sub_category.dart';
import 'package:re3aity/User/screens/SingleSection/Bloc/AddReservationCubit.dart';
import 'package:re3aity/User/screens/SingleSection/Bloc/AddReservationState.dart';
import 'package:re3aity/User/screens/Notification/Notification_Screen.dart';
import 'package:re3aity/User/screens/Sections/Sections.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomAppBar.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomCard.dart';
import 'package:re3aity/common/CustomDialog.dart';
import 'package:re3aity/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReservation extends StatefulWidget {
  final Subcategory? person;
  final String? serviceName;
  final int? catID, providerID;
  final bool? skip;

  const AddReservation({this.person, this.serviceName, this.catID, this.skip, this.providerID,});

  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  bool _clinicChecked = false;
  bool _homeChecked = false;
  DateTime? _pickedDate;
  TimeOfDay? _time;
  List place = ["العيادة", "المنزل"];
  int? userID;


  void shared() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setInt("cat_id", widget.catID!);
  }

  @override
  void initState() {
    final cubit = AddReservationCubit.get(context);
    print("owner Id ::::::::::::: ${widget.providerID}");
    cubit.owner_id = widget.providerID!;
    shared();
    _pickedDate = DateTime.now();
    _time = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("id============. ${widget.catID}");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTilte: widget.person!.user!.name,
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage(skip: widget.skip))),
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

                widget.skip == true
                    ? CustomButton(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        text: "حجز",
                        bottomPadding: 10,
                        topPadding: 10,
                        rightPadding: 0,
                        leftPadding: 0,
                        onTap: () {
                          showDialog(context: context, builder: (_){
                            return LoginAlertDialog();
                          });
                        },
                      )
                    : reservationButton(context),
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
                        image: NetworkImage("https://my-care.life/public/dash/assets/img/${widget.person!.user!.image}"),
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
                      widget.person!.user!.address ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Cairo-Bold",
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    RatingBar.builder(
                      initialRating: widget.person!.user!.rate!.toDouble(),
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
                    .colorScheme.secondary,
              ),
            ),
            Divider(),
            Text(
              widget.person!.user!.desc ?? "",
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

  //===================================== provider Service ===========================================
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
              "الخدمات",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo-Bold",
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Divider(),

            Row(
              children: [
                Text(
                  "نوع الخدمة المقدمة : ",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Cairo-Bold",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  widget.serviceName ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "سعر الخدمة فى المنزل : ",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Cairo-Bold",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "${widget.person!.homeprice} ريال",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
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
                    fontFamily: "Cairo-Bold",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "${widget.person!.clincprice} ريال",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
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
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Divider(),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //============== مكان مقدم الخدمة ===============
                  CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: place[0],
                    fontsize: 13,
                    bottomPadding: 0,
                    topPadding: 0,
                    rightPadding: 0,
                    leftPadding: 2,
                    textColor: _clinicChecked == true
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                    color: _clinicChecked == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
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
                    fontsize: 14,
                    topPadding: 0,
                    rightPadding: 2,
                    leftPadding: 0,
                    textColor: _homeChecked == true
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                    color: _homeChecked == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
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
                    "${_pickedDate!.day} / ${_pickedDate!.month} / ${_pickedDate!.year}",
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
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: _pickedDate!,
                  firstDate: DateTime(DateTime.now().day),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (date == null) {
                  setState(() {
                    cubit.date = _pickedDate.toString();
                  });
                } else {
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
                    "${_time!.hour} : ${_time!.minute}",
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
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: _time!,
                );
                if (time == null) {
                  cubit.time = _time!.format(context);
                } else {
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

  //=================================== Reservation Button ==========================================
  Widget reservationButton(BuildContext context){
    final cubit = AddReservationCubit.get(context);
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: BlocConsumer<AddReservationCubit, AddReservationState>(
        listener: (_, state) async {
          SharedPreferences _pref = await SharedPreferences.getInstance();
          // if(_pref.getInt("pro_id") == null){
          //   Scaffold.of(_).showSnackBar(SnackBar(
          //     backgroundColor: Theme.of(_).primaryColor,
          //     content: Text("مقدم الخدمة غير متاح حاليا",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: "Cairo-Regular")),
          //   ));
        // }else
          if(state is AddReservationErrorState && _pref.getInt("pro_id") == null){
            ScaffoldMessenger.of(_).showSnackBar(SnackBar(
              backgroundColor: Theme.of(_).primaryColor,
              content: Text(state.error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),),
            ));
          }else if(state is AddReservationSuccessState){
            Navigator.pushAndRemoveUntil(_, MaterialPageRoute(builder: (_) => Sections(skip: false)), (route) => false);
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
                  onTap: () {
                    cubit.postAddReservation();
                  },
                );
        },
      ),
    );
  }
}
