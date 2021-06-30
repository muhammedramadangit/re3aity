import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/Components/Gender.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterState.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/common/CustomTextFieldTap.dart';
import 'package:lastre3ayty/theme/color.dart';

class ProviderCompleteRegister extends StatefulWidget {
  final String gender;

  ProviderCompleteRegister({this.gender});

  @override
  _ProviderCompleteRegisterState createState() =>
      _ProviderCompleteRegisterState();
}

class _ProviderCompleteRegisterState extends State<ProviderCompleteRegister> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showItem = false;
  LocationResult _pickedLocation;
  String locationLabel = "الموقع";
  String foos = "الخدمة المقدمة";

  // Map foos = {
  //   "services" : "الخدمة المقدمة",
  //   "doctor" : "طبيب",
  //   "homeservice" : "خدمات منزلية",
  //   "plumbing" : "سباكة",
  //   "electricity" : "كهرباء",
  // };

  double lat = 31.1975844, lng = 29.9598339;

  @override
  Widget build(BuildContext context) {
    final cubit = CompleteRegisterCubit.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //============ Logo Position ===========
                    AnimatedWidgets(
                      duration: 1,
                      horizontalOffset: 0,
                      virticaloffset: 50,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/app_logo.png'),
                          ),
                        ),
                      ),
                    ),

                    //============ SignUp Card =============
                    AnimatedWidgets(
                      duration: 1.5,
                      horizontalOffset: 0,
                      virticaloffset: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Card(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          elevation: 3,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 10),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      'اكمل البيانات',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cairo-Bold',
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 15),

                                    //============= الاسم =============
                                    CustomTextField(
                                      horizontalPadding: 10,
                                      labelSize: 12,
                                      leftPadding: 5,
                                      rightPadding: 5,
                                      verticalPadding: 0,
                                      secureText: false,
                                      label: "الاسم",
                                      inputType: TextInputType.name,
                                      prefixIcon: customRegisterIcon(imgSrc: "assets/icons/username.png"),
                                      validate: (val) {
                                        if (val.isEmpty) {
                                          return "برجاء إدخال اسم الاسم";
                                        }
                                      },
                                      onChanged: (val) {
                                        cubit.name = val;
                                      },
                                    ),

                                    //============= الخدمة المتقدمة =============
                                    // CustomTextFieldTap(
                                    //   lable: "الخدمة المتقدمة",
                                    //   prefixIcon: customRegisterIcon(
                                    //       imgSrc: "assets/icons/service.png"),
                                    //   icon: showItem == true
                                    //       ? Icon(Icons.keyboard_arrow_down,
                                    //           size: 25,
                                    //           color: ThemeColor.lighterGreyText)
                                    //       : Icon(Icons.arrow_forward_ios,
                                    //           size: 18,
                                    //           color:
                                    //               ThemeColor.lighterGreyText),
                                    //   onTap: () {
                                    //     setState(() {
                                    //       showItem = !showItem;
                                    //     });
                                    //   },
                                    // ),
                                    //
                                    // showItem == true
                                    //     ? AnimatedWidgets(
                                    //         duration: 1,
                                    //         horizontalOffset: 0,
                                    //         virticaloffset: -50,
                                    //         child: AdvancedService(),
                                    //       )
                                    //     : SizedBox(height: 0),

                                    //============= الخدمة المتقدمة =============

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                      padding: EdgeInsets.only(right: 0, left: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[100],
                                      ),
                                      child: ExpansionTile(
                                        tilePadding: EdgeInsets.only(right: 12.0, left: 8, top: 0, bottom: 0),
                                        title: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            customRegisterIcon(imgSrc: "assets/icons/service.png"),
                                            SizedBox(width: 12),
                                            Expanded(
                                                child: Text(foos, style: TextStyle(fontSize: 12, color: ThemeColor.lighterGreyText))),
                                          ],
                                        ),
                                        backgroundColor: Colors.transparent,
                                        childrenPadding: EdgeInsets.symmetric(horizontal: 5),
                                        collapsedBackgroundColor: Colors.transparent,
                                        trailing: showItem == true
                                            ? Icon(Icons.keyboard_arrow_down,
                                                size: 25,
                                                color: Theme.of(context).accentColor)
                                            : Icon(Icons.arrow_forward_ios,
                                                size: 18,
                                                color: Theme.of(context).accentColor),
                                        onExpansionChanged: (val) {
                                          setState(() {
                                            showItem = !showItem;
                                          });
                                        },
                                        children: [
                                          ListTile(
                                            title: Text(
                                              "طبيب",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context).accentColor,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                this.foos = "طبيب";
                                                cubit.desc = this.foos;
                                              });
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "خدمات منزلية",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    ThemeColor.lighterGreyText,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                this.foos= "خدمات منزلية";
                                                cubit.desc = this.foos;
                                              });
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "سباكة",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    ThemeColor.lighterGreyText,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                this.foos = "سباكة";
                                                cubit.desc = this.foos;
                                              });
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "كهرباء",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    ThemeColor.lighterGreyText,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                this.foos = "كهرباء";
                                                cubit.desc = this.foos;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    //============= الجنس =============
                                    CustomTextFieldTap(
                                      lable: cubit.sex == null
                                          ? "الجنس"
                                          : cubit.sex,
                                      prefixIcon: customRegisterIcon(
                                          imgSrc: "assets/icons/gender.png"),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) =>ProviderGender()));
                                      },
                                    ),

                                    //============= الموقع =============
                                    CustomTextFieldTap(
                                      lable: locationLabel,
                                      prefixIcon: customRegisterIcon(imgSrc: "assets/icons/location.png"),
                                      onTap: () async {
                                        LocationResult result = await showLocationPicker(
                                          context,
                                          "AIzaSyBU6YNVxesC2-qRF2yDgCk7be8QaQz56kQ",
                                          initialCenter: LatLng(lat, lng),
                                          myLocationButtonEnabled: true,
                                          layersButtonEnabled: true,
                                          desiredAccuracy: LocationAccuracy.best,
                                        );
                                        print("result = $result");
                                          setState(() {
                                            cubit.address = result.address;
                                            cubit.lat = result.latLng.latitude.toString();
                                            cubit.lng = result.latLng.longitude.toString();
                                            locationLabel = result.address.toString();
                                          });
                                      },
                                    ),

                                    SizedBox(height: 10),

                                    //====================== حفظ ======================
                                    BlocConsumer<CompleteRegisterCubit, CompleteRegisterState>(
                                      listener: (_, state) {
                                        if (state is CompleteRegisterErrorState) {
                                          Scaffold.of(_).showSnackBar(SnackBar(
                                            backgroundColor: Theme.of(_).primaryColor,
                                            content: Text(
                                              state.error,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ));
                                        } else if (state is CompleteRegisterSuccessState) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      ProviderMainDrawer(appBarTitle: "حجوزاتي", index: 0)));
                                          print("================ تم اكمال تسجيل البيانات بنجاح ==========");
                                          print("==== name : ${cubit.name} | Categories : ${cubit.categories} | gender : ${cubit.sex} | address : ${cubit.address} |=");
                                        }
                                      },
                                      builder: (context, state) {
                                        return state is CompleteRegisterLoadingState
                                            ? Center(
                                                child: SpinKitChasingDots(
                                                  size: 25,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              )
                                            : CustomButton(
                                                text: "حفظ",
                                                width: MediaQuery.of(context).size.width /2,
                                                height: 40,
                                                onTap: () {
                                                  if (formKey.currentState.validate()) {
                                                    cubit.postCompleteRegister();
                                                  }
                                                },
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
