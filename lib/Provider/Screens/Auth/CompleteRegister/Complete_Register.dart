import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lastre3ayty/Provider/Controller/SelectCateController.dart';
import 'package:lastre3ayty/Provider/Models/SelectCateModel.dart';
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
import 'package:multiselect_formfield/multiselect_formfield.dart';

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
  double lat = 31.1975844, lng = 29.9598339;



  SelectCateModel _selectCateModel =SelectCateModel();
  SelectCateController _selectCateController = SelectCateController();
  bool loading = true;

  void getCate() async {
    _selectCateModel = await _selectCateController.getSelectCate();
    setState(() {
      loading=false;
    });
  }

  @override
  void initState() {
    getCate();

    super.initState();
  }

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
              alignment: Alignment.topCenter,
              child: SafeArea(
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

                                      //============= نبذة عنك =============
                                      CustomTextField(
                                        horizontalPadding: 10,
                                        labelSize: 12,
                                        leftPadding: 5,
                                        rightPadding: 5,
                                        verticalPadding: 0,
                                        secureText: false,
                                        // lines: 3,
                                        label: "نبذة عنك",
                                        inputType: TextInputType.name,
                                        prefixIcon: customRegisterIcon(imgSrc: "assets/icons/desc.png"),
                                        validate: (val) {
                                          if (val.isEmpty) {
                                            return "برجاء إدخال نبذة عنك";
                                          }
                                        },
                                        onChanged: (val) {
                                          cubit.desc = val;
                                        },
                                      ),

                                      //============= الخدمة المقدمة =============
                                      loading ? Center(
                                        child: SpinKitChasingDots(
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ) : _drawSelectServicesForm(context),

                                      //============== عرض السعر ================
                                      cubit.catIds==null ? Container()
                                          : Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            child: _drawSelectedServicesPrice(context),
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
                                                    // cubit.catIds.clear();
                                                    // cubit.homePrices.clear();
                                                    // cubit.clinicPrices.clear();

                                                      for (int i = 0; i < cubit.catIds.length; i++) {
                                                      print(cubit.homePrices[i]);
                                                      cubit.categories.add({
                                                        "cat_id": cubit.catIds[i],
                                                        "home_price": cubit.homePrices[i],
                                                        "clinic_price": cubit.clinicPrices[i],
                                                      });

                                                      if (formKey.currentState.validate()) {
                                                        cubit.postCompleteRegister();
                                                      }
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSelectServicesForm(BuildContext context) {
    final cubit = CompleteRegisterCubit.get(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      padding: EdgeInsets.only(right: 0, left: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      child: MultiSelectFormField(
        autovalidate: false,
        leading: customRegisterIcon(imgSrc: "assets/icons/service.png"),
        dialogShapeBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey[100],
        checkBoxActiveColor: Theme.of(context).primaryColor,
        checkBoxCheckColor: Colors.white,
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).accentColor),
        title: Text("الخدمة المقدمة", style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
        hintWidget: null,
        // Text("من فضلك اختر خدمه او اكثر", style: TextStyle(fontSize: 10, color: ThemeColor.lighterGreyText)),
        dataSource: _selectCateModel.data.map((e) {
          return
            {
              "display" : e.categories.name,
              "value" : e.categories.id.toString(),
            };
        }).toList(),

        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'تاكيد',
        cancelButtonLabel: 'الغاء',
        initialValue: cubit.catIds,
        // ignore: missing_return
        validator: (value) {
          if (value == null || value.length == 0) {
            return "من فضلك اختر خدمه او اكثر";
          }
        },
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            print(value);
            cubit.catIds = value;
          });
        },
      ),
    );
  }


  Widget _drawSelectedServicesPrice(BuildContext context) {
    final cubit = CompleteRegisterCubit.get(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        itemCount: cubit.catIds.length,
        itemBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: <Widget>[
                Text("سعر الخدمة", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomTextField(
                      horizontalPadding: 0,
                      labelSize: 12,
                      leftPadding: 5,
                      rightPadding: 5,
                      verticalPadding: 0,
                      width: MediaQuery.of(context).size.width * .32,
                      label: "المنزل",
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("ريال", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                      ),
                      inputType: TextInputType.number,
                      validate: (val){
                        if(val.isEmpty){
                          return "من فضلك ادخل سعر المنزل";
                        }
                      },
                      onChanged: (String val){
                        setState(() {
                          cubit.homePrices.add(val);
                        });
                      },
                    ),
                    CustomTextField(
                      horizontalPadding: 0,
                      labelSize: 12,
                      leftPadding: 5,
                      rightPadding: 5,
                      verticalPadding: 0,
                      width: MediaQuery.of(context).size.width * .32,
                      label: "العيادة",
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("ريال", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                      ),
                      inputType: TextInputType.number,
                      validate: (val){
                        if(val.isEmpty){
                          return "من فضلك ادخل سعر العيادة";
                        }
                      },
                      onChanged: (val){
                        setState(() {
                          cubit.clinicPrices.add(val.toString());
                        });
                      },
                    ),

                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
