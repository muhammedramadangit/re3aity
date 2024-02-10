import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:re3aity/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_Cubit.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_State.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_Cubit.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_State.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomAppBar.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomButtonSheet.dart';
import 'package:re3aity/common/CustomDialog.dart';
import 'package:re3aity/common/CustomRegisterIcon.dart';
import 'package:re3aity/common/CustomTextField.dart';
import 'package:re3aity/common/CustomTextFieldTap.dart';
import 'package:re3aity/common/CustonSnackBar.dart';

class EditProviderProfile extends StatefulWidget {
  final ProviderProfileCubit? profileCubit;

  EditProviderProfile({Key? key, this.profileCubit});

  @override
  _EditProviderProfileState createState() => _EditProviderProfileState();
}

class _EditProviderProfileState extends State<EditProviderProfile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double lat = 31.1975844, lng = 29.9598339;
  String locationLabel = "العنوان الجديد";
  final picker = ImagePicker();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var addressController=TextEditingController();

  Future pickImage() async {
    final cubit = EditProviderCubit.get(context);
    final image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null){
        cubit.image = File(image.path);
      } else {
        print("No image selected!!!!");
      }
    });
  }

  Future getImage() async {
    final cubit = EditProviderCubit.get(context);
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null){
        cubit.image = File(image.path);
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
    final cubit = EditProviderCubit.get(context);
    nameController.text = widget.profileCubit!.providerProfileModel!.data!.name!;
    phoneController.text = widget.profileCubit!.providerProfileModel!.data!.phone!;
    addressController.text = widget.profileCubit!.providerProfileModel!.data!.address!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(
          context: context,
          appBarTilte: "تعديل الصفحة الشخصية",
        ),

        body: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
          listener: (_, state){},
          builder: (context, state){
            return Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
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
                                  child: cubit.image == null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://my-care.life/public/dash/assets/img/${widget.profileCubit!.providerProfileModel!.data!.image}"),
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                      : Image.file(cubit.image!, fit: BoxFit.cover),
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
                                      color: Theme.of(context).primaryColor, fit: BoxFit.cover))),
                          validate: (val) {
                            if(val!.isEmpty){
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
                            if(val!.isEmpty){
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
                          height: 45,
                          prefixIcon: customRegisterIcon(imgSrc: "assets/icons/location.png"),
                          onTap: () async {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlacePicker(
                                  apiKey: "AIzaSyBU6YNVxesC2-qRF2yDgCk7be8QaQz56kQ",
                                  initialPosition: const LatLng(23.8859, 45.0792),
                                  enableMyLocationButton: true,
                                  selectInitialPosition: true,
                                  useCurrentLocation: true,
                                  onPlacePicked: (result){
                                    setState(() {
                                      cubit.address = result.formattedAddress;
                                      cubit.lat = result.geometry!.location.lng.toString();
                                      cubit.lng = result.geometry!.location.lng.toString();
                                      locationLabel = result.formattedAddress.toString();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Expanded(child: Container()),
                      // SizedBox(height: MediaQuery.of(context).size.height / 3),

                      //======================= حفظ ======================
                      AnimatedWidgets(
                        duration: 1.5,
                        virticaloffset: 50,
                        horizontalOffset: 0,
                        child: BlocConsumer<EditProviderCubit, EditProviderState>(
                          listener: (_, state){
                            if(state is EditProviderErrorState){
                              customSnackBar(_, state.error);
                            }else if(state is EditProviderSuccessState){
                              print("SUCCESS");
                              Navigator.pushAndRemoveUntil(_, MaterialPageRoute(builder: (_) => ProviderMainDrawer(appBarTitle: "حجوزاتي", index: 0)), (route) => false);
                              showDialog(context: _, builder: (_){
                                return CustomDialog(msg: "تم تعديل البيانات بنجاح", navRoute: () => Navigator.pop(_));
                              });
                            }
                          },
                          builder: (context, state){
                            return state is EditProviderLoadingState
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
                                        if (_formKey.currentState!.validate()) {
                                          cubit.editProvider();
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
            );
          },
        ),
      ),
    );
  }


}
