import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastre3ayty/User/screens/Profile/Edit_Profile/bloc/Edit_Cubit.dart';
import 'package:lastre3ayty/User/screens/Profile/Edit_Profile/bloc/Edit_State.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/model/ProfileModel.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomButtonSheet.dart';
import 'package:lastre3ayty/common/CustomDialog.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/common/CustomTextFieldTap.dart';
import 'package:lastre3ayty/common/CustonSnackBar.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel profileModel;

  EditProfile({this.profileModel});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double lat = 31.1975844, lng = 29.9598339;
  String locationLabel = "العنوان الجديد";
  File _imgSrc;
  final picker = ImagePicker();


  Future pickImage() async {
    final cubit = EditProfileCubit.get(context);
    final image = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (image != null){
        _imgSrc = File(image.path);
        cubit.image = _imgSrc;
      } else {
        print("No image selected!!!!");
      }
    });
  }

  Future getImage() async {
    final cubit = EditProfileCubit.get(context);
    final image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null){
        _imgSrc = File(image.path);
        cubit.image = _imgSrc;
      } else {
        print("No image selected!!!!");
      }
    });
  }

  void imageBottomSheet() {
    customSheet(
      context: context,
      widget: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text("الكاميرا", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                leading: Icon(CupertinoIcons.photo_camera_solid, color: Theme.of(context).primaryColor),
                onTap: pickImage,
              ),
              ListTile(
                title: Text("الأستديو", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                leading: Icon(CupertinoIcons.photo, color: Theme.of(context).primaryColor),
                onTap: getImage,
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = EditProfileCubit.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(
          context: context,
          appBarTilte: "الاعدادات",
        ),

        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //================ تعديل الصورة الشخصية ==================
                  // AnimatedWidgets(
                  //   duration: 1.5,
                  //   virticaloffset: -50,
                  //   horizontalOffset: 0,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 40),
                  //     child: Stack(
                  //       children: [
                  //         ClipRRect(
                  //           borderRadius: BorderRadius.circular(60),
                  //           child: Container(
                  //             height: 120,
                  //             width: 120,
                  //             color: Colors.grey[50],
                  //             child: _imgSrc == null
                  //                 ? Container(
                  //                     decoration: BoxDecoration(
                  //                         image: DecorationImage(
                  //                             image: NetworkImage("https://mycare.pro/public/dash/assets/img/${widget.profileModel.data.image}"),
                  //                             fit: BoxFit.cover
                  //                         ),
                  //                     ),
                  //                   ) : Image.file(cubit.image, fit: BoxFit.cover),
                  //           ),
                  //         ),
                  //         Positioned(
                  //           bottom: 0,
                  //           right: 0,
                  //           child: IconButton(
                  //             onPressed: imageBottomSheet,
                  //             icon: Icon(CupertinoIcons.photo_camera_solid, color: Theme.of(context).primaryColor, size: 28),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  //================ اسم المستخدم الجديد ==================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: 0,
                    horizontalOffset: 50,
                    child: CustomTextField(
                      horizontalPadding: 0,
                      labelSize: 12,
                      leftPadding: 0,
                      rightPadding: 0,
                      verticalPadding: 4,
                      secureText: false,
                      label: "اسم المستخدم الجديد",
                      inputType: TextInputType.name,
                      prefixIcon: Container(
                          height: 20,
                          width: 20,
                          child: Center(
                              child: Image.asset("assets/icons/profile.png",
                                  height: 20,
                                  width: 20,
                                  color: Theme.of(context).primaryColor,
                                  fit: BoxFit.cover))),
                      validate: (val) {
                        if(val.isEmpty){
                          return "برجاء إدخال اسم المستخدم الجديد";
                        }
                      },
                      onChanged: (value){
                        cubit.name = value;
                      },
                    ),
                  ),

                  //================ رقم الجوال الجديد ==================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: 0,
                    horizontalOffset: 50,
                    child: CustomTextField(
                      horizontalPadding: 0,
                      labelSize: 12,
                      leftPadding: 0,
                      rightPadding: 0,
                      verticalPadding: 4,
                      secureText: false,
                      label: "رقم الجوال الجديد",
                      inputType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone, size: 18, color: Theme.of(context).primaryColor),
                      suffixIcon: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Divider(),
                          Text("+966", textDirection: TextDirection.ltr, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                        ],
                      ),
                      validate: (val) {
                        if(val.isEmpty){
                          return "برجاء إدخال رقم الجوال الجديد";
                        }else if(val.length < 9 || val.length > 9){
                          return "يشترط رقم الجوال 9 أرفام";
                        }
                      },
                      onChanged: (value){
                        cubit.phone = value;
                      },
                    ),
                  ),

                  //================ العنوان الجديد ==================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: 0,
                    horizontalOffset: 50,
                    child: CustomTextFieldTap(
                      lable: locationLabel,
                      horizontalPadding: 0,
                      verticalPadding: 8,
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
                  ),

                  // Expanded(child: Container()),
                  SizedBox(height: MediaQuery.of(context).size.height / 5.5),

                  //======================= حفظ ======================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: 50,
                    horizontalOffset: 0,
                    child: BlocConsumer<EditProfileCubit, EditProfileState>(
                      listener: (_, state){
                        if(state is EditProfileErrorState){
                          customSnackBar(_, state.error);
                        }else if(state is EditProfileSuccessState){
                          print("SUCCESS");
                          Navigator.of(_).pop(cubit);
                          showDialog(context: _, builder: (_){
                            return CustomDialog(msg: "تم تعديل البيانات بنجاح", navRoute: () => Navigator.pop(_));
                          });
                        }
                      },
                      builder: (context, state){
                        return state is EditProfileLoadingState
                        ? CenterLoading()
                        : Container(
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            text: "حفظ",
                            bottomPadding: 10,
                            topPadding: 10,
                            rightPadding: 0,
                            leftPadding: 0,
                            onTap: () {

                              if(_formKey.currentState.validate()){
                                cubit.editProfile();
                              }
                            },
                          ),
                        );
                      },
                    ),

                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
