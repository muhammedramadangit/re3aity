import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomAppBar.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomButtonSheet.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/common/CustomTextFieldTap.dart';

class EditProviderProfile extends StatefulWidget {
  @override
  _EditProviderProfileState createState() => _EditProviderProfileState();
}

class _EditProviderProfileState extends State<EditProviderProfile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File _imgSrc;
  final picker = ImagePicker();

  Future pickImage() async {
    final image = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (image != null){
        _imgSrc = File(image.path);
      } else {
        print("No image selected!!!!");
      }
    });
  }

  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null){
        _imgSrc = File(image.path);
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(
          context: context,
          appBarTilte: "الاعدادات",
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //================ تعديل الصورة الشخصية ==================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: -50,
                    horizontalOffset: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              height: 120,
                              width: 120,
                              color: Colors.grey[50],
                              child: _imgSrc == null ? Image.asset("assets/images/doctor.jpg", fit: BoxFit.cover): Image.file(_imgSrc, fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: imageBottomSheet,
                              icon: Icon(CupertinoIcons.photo_camera_solid, color: Theme.of(context).primaryColor, size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                        height: 45,
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
                                    color: Theme.of(context).primaryColor, fit: BoxFit.cover)))),
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
                      height: 45,
                      secureText: false,
                      label: "رقم الجوال الجديد",
                      inputType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone, size: 18, color: Theme.of(context).primaryColor),
                    ),
                  ),

                  //================ العنوان الجديد ==================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: 0,
                    horizontalOffset: 50,
                    child: CustomTextFieldTap(
                      verticalPadding: 4,
                      horizontalPadding: 0,
                      height: 45,
                      lable: "العنوان الجديد",
                      prefixIcon: Icon(Icons.location_on_outlined, size: 18, color: Theme.of(context).primaryColor),
                      onTap: () {},
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 5),

                  //======================= حفظ ======================
                  AnimatedWidgets(
                    duration: 1.5,
                    virticaloffset: 50,
                    horizontalOffset: 0,
                    child: CustomButton(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      text: "حفظ",
                      bottomPadding: 8,
                      topPadding: 8,
                      rightPadding: 0,
                      leftPadding: 0,
                      onTap: () => Navigator.pop(context),
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
