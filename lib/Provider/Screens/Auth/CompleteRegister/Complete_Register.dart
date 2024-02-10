import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:re3aity/Provider/Controller/SelectCateController.dart';
import 'package:re3aity/Provider/Models/SelectCateModel.dart';
import 'package:re3aity/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:re3aity/Provider/Screens/Auth/CompleteRegister/Components/Gender.dart';
import 'package:re3aity/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterCubit.dart';
import 'package:re3aity/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterState.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomButton.dart';
import 'package:re3aity/common/CustomRegisterIcon.dart';
import 'package:re3aity/common/CustomTextField.dart';
import 'package:re3aity/common/CustomTextFieldTap.dart';
import 'package:re3aity/common/CustonSnackBar.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class ProviderCompleteRegister extends StatefulWidget {
  final String? gender;

  ProviderCompleteRegister({this.gender});

  @override
  _ProviderCompleteRegisterState createState() =>
      _ProviderCompleteRegisterState();
}

class _ProviderCompleteRegisterState extends State<ProviderCompleteRegister> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showItem = false;
  PickResult? selectedPlace;
  // LocationResult? _pickedLocation;
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
                                          if (val!.isEmpty) {
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
                                          if (val!.isEmpty) {
                                            return "برجاء إدخال نبذة عنك";
                                          }
                                        },
                                        onChanged: (val) {
                                          cubit.desc = val;
                                        },
                                      ),

                                      //============= الخدمة المقدمة =============
                                      loading ? CenterLoading() : _drawSelectServicesForm(context),

                                      //============== عرض السعر ================
                                      cubit.catIds == null
                                          ? Container()
                                          : _drawSelectedServicesPrice(context),

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
                                                    cubit.lat = result.geometry?.location.lat.toString();
                                                    cubit.lng = result.geometry?.location.lng.toString();
                                                    locationLabel = result.formattedAddress!;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                                      SizedBox(height: 10),

                                      //====================== حفظ ======================
                                      BlocConsumer<CompleteRegisterCubit, CompleteRegisterState>(
                                        listener: (_, state) {
                                          if (state is CompleteRegisterErrorState) {
                                            customSnackBar(_, state.error);
                                          } else if (state is CompleteRegisterSuccessState) {
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>ProviderMainDrawer(appBarTitle: "حجوزاتي", index: 0)), (route) => false);
                                            print("================ تم اكمال تسجيل البيانات بنجاح ==========");
                                          }
                                        },
                                        builder: (context, state) {
                                          return state is CompleteRegisterLoadingState
                                              ? CenterLoading()
                                              : CustomButton(
                                                  text: "حفظ",
                                                  width: MediaQuery.of(context).size.width /2,
                                                  height: 40,
                                                  onTap: () {
                                                    List uu=[];
                                                        cubit.catIds!.map((item)=>uu.add({
                                                        "cat_id": item!.catId,
                                                        "home_price":  item.price,
                                                        "clinic_price": item.priceHome,
                                                        })).toList();
                                                      cubit.categories=uu;

                                                      if (formKey.currentState!.validate()) {
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
        autovalidate: AutovalidateMode.disabled,
        leading: customRegisterIcon(imgSrc: "assets/icons/service.png"),
        dialogShapeBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey[100],
        checkBoxActiveColor: Theme.of(context).primaryColor,
        checkBoxCheckColor: Colors.white,
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).colorScheme.secondary),
        title: Text("الخدمة المقدمة", style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary)),
        hintWidget: SizedBox(),
        // Text("من فضلك اختر خدمه او اكثر", style: TextStyle(fontSize: 10, color: ThemeColor.lighterGreyText)),
        dataSource: _selectCateModel.data!.map((e) {
          return
            {
              "display" : e!.categories!.name,
              "value" :  e.categories!.id,
            };
        }).toList(),

        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'تاكيد',
        cancelButtonLabel: 'الغاء',
        initialValue: cubit.catIds!.map((e) => e!.catId).toList(),
        // ignore: missing_return
        validator: (value) {

          if (value == null || value.length == 0) {
            return "من فضلك اختر خدمه او اكثر";
          }
        },
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            cubit.catIds=[];
             value.map((item)=> cubit.catIds!.add(CatyPrice(catId: item))).toList();
           // cubit.catIds = value;
            print(cubit.catIds);
            // cubit.homePrice=[];

          });
        },
      ),
    );
  }


  Widget _drawSelectedServicesPrice(BuildContext context) {
    final cubit = CompleteRegisterCubit.get(context);
    return ListView.builder(
      primary: false,
      //physics: ,
      shrinkWrap: true,
      itemCount: cubit.catIds!.length,
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
                    label: "العيادة",
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("ريال", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                    ),
                    inputType: TextInputType.number,
                    validate: (val){
                      if(val!.isEmpty){
                        return "من فضلك ادخل سعر الخدمة فى العيادة";
                      }
                    },
                    onChanged: (val){
                      var cat =cubit.catIds;
                      cat![position]=cat[position]!.copyWith(priceHome:val);
                      cubit.catIds=cat;
                    },
                  ),
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
                    inputType: TextInputType.phone,
                    validate: (val){
                      if(val!.isEmpty){
                        return "من فضلك ادخل سعر الخدمة فى المنزل";
                      }
                    },
                    onChanged: (val){
                      var cat =cubit.catIds;
                      cat![position]=cat[position]!.copyWith(price:val);
                      cubit.catIds=cat;

                    },
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
