// import 'package:app_settings/app_settings.dart';
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:lastre3ayty/api/post_helpers_api.dart';
// import 'package:lastre3ayty/models/selectCateModel.dart';
// import 'package:lastre3ayty/screens/map_screen/map_request.dart';
// import 'package:lastre3ayty/screens/map_screen/map_screen.dart';
// import 'package:lastre3ayty/screens/register_screens/confirm_account.dart';
// import 'package:lastre3ayty/screens/register_screens/selectController/selectCateConttroller.dart';
// import 'package:lastre3ayty/utilities/screen_config.dart';
// import 'package:lastre3ayty/utilities/screen_utilities.dart';
// import 'package:lastre3ayty/utilities/utilities_data.dart';
// import 'package:toast/toast.dart';
// import 'package:multiselect_formfield/multiselect_formfield.dart';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lastre3ayty/re3aytiii/Custom/ScreenConfigurations.dart';
import 'package:lastre3ayty/re3aytiii/Custom/post_helpers_api.dart';
import 'package:lastre3ayty/re3aytiii/Custom/selectCateConttroller.dart';
import 'package:lastre3ayty/re3aytiii/Custom/selectCateModel.dart';
import 'package:lastre3ayty/re3aytiii/Custom/utilities_data.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';




class CompleteRegisterDataScreen extends StatefulWidget {
  int userID;
  String apiToken;

  CompleteRegisterDataScreen({this.userID, this.apiToken});

  @override
  _CompleteRegisterDataScreenState createState() =>
      _CompleteRegisterDataScreenState();
}

class _CompleteRegisterDataScreenState
    extends State<CompleteRegisterDataScreen> {
  double screenWidth;

  double screenHeight;

  ScreenConfigurations screenConfigurations;

  WidgetsSize _widgetsSize;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  List _services;
  List<String> _servicePricesh = [];
  List<String> _servicePricesc = [];
  List<Map<String, dynamic>> categories;

  int userID;
  SharedPreferences sharedPreferences;

  // PostHelperApi _postHelperApi = PostHelperApi();

  List<String> _gender = [
    'ذكر',
    'انثي',
  ];
  String _selectedGender;

  String _name;
  String _title;
  double _lat;
  double _long;

  TextEditingController _nameController;

  TextEditingController _titleController;
  TextEditingController _description;
  SelectCateModel _selectCateModel =SelectCateModel();
  SelectCateController _selectCateController = SelectCateController();
  bool loading= true;
  void _getCate()async{
    // _selectCateModel = await _selectCateController.getSelectCate();
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _nameController = TextEditingController();
    _getCate();
    _services = [];
    _description = TextEditingController();
    categories = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfigurations = ScreenConfigurations(context);

    _widgetsSize = WidgetsSize(screenConfigurations);

    screenHeight = MediaQuery.of(context).size.height;

    screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/background.jpeg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _drawBody(),
        ),
      ],
    );
  }

  _drawBody() {
    return Center(
      child: SizedBox(
        width: screenWidth * 0.8,
        height: screenHeight * 0.9,
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          elevation: 2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DrawSingleText(
                    title: 'اكمل البيانات',
                    fontSize: _widgetsSize.small14,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _drawForm(),
                  SizedBox(
                    height: 10,
                  ),
                  // drawGradientRaisedButton(
                  //   'حفظ',
                  //       () async {
                  //     if (_formKey.currentState.validate()) {
                  //       _formKey.currentState.save();
                  //       print(_servicePricesh);
                  //       setState(() {
                  //         isLoading = true;
                  //       });
                  //
                  //       // drawToast(context, "من فضلك انتظر", Toast.CENTER);
                  //
                  //       _name = _nameController.text;
                  //       _title = _titleController.text;
                  //       categories.clear();
                  //       for (int i = 0; i < _services.length; i++) {
                  //         categories.add({
                  //           "cat_id": _services[i],
                  //           "home_price": _servicePricesh[i],
                  //           "clinic_price": _servicePricesc[i]
                  //         });
                  //       }
                  //       userID = widget.userID;
                  //
                  //       print(categories);
                  //       var response = await _postHelperApi.completeData(
                  //           userID: userID.toString(),
                  //           name: _name,
                  //           sex: _selectedGender,
                  //           lat: _lat.toString(),
                  //           long: _long.toString(),
                  //           title: _title,
                  //           categories: categories,
                  //           desc:_description.text
                  //       );
                  //
                  //       if (response.msg == 'success') {
                  //         print(widget.userID);
                  //         print(widget.apiToken);
                  //         saveUser(
                  //           userID: widget.userID,
                  //           apiToken: widget.apiToken,
                  //         );
                  //         // Navigator.of(context).pushAndRemoveUntil(
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) => ConfirmAccount()),
                  //         //         (Route<dynamic> route) => false);
                  //       } else {
                  //         // drawToast(context, response.msg, Toast.CENTER);
                  //         setState(() {
                  //           isLoading = false;
                  //         });
                  //       }
                  //     } else {
                  //       setState(() {
                  //         isLoading = false;
                  //       });
                  //     }
                  //   },
                  //   screenWidth * 0.6,
                  //   _widgetsSize.small14,
                  //   Colors.white,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawForm() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DrawSingleTextFormField(
              labelText: 'الاسم',
              labelStyle: TextStyle(
                fontFamily: 'Cairo',
                color: Theme.of(context).primaryColor,
                fontSize: _widgetsSize.small14 - 2,
              ),
              textAlign: TextAlign.end,
              icon: Icons.perm_identity,
              iconSize: _widgetsSize.small20,
              keyboardType: TextInputType.text,
              secure: false,
              controller: _nameController,
              maxLines: 1,
              validatorWarning: "من فضلك ادخل الاسم",
            ),
            SizedBox(
              height: 20,
            ),
            DrawSingleTextFormField(
              labelText: 'نبذة عنك',
              labelStyle: TextStyle(
                fontFamily: 'Cairo',
                color: Theme.of(context).primaryColor,
                fontSize: _widgetsSize.small14 - 2,
              ),
              textAlign: TextAlign.end,
              icon: Icons.perm_identity,
              iconSize: _widgetsSize.small20,
              keyboardType: TextInputType.text,
              secure: false,
              controller: _description,
              maxLines: 1,
              validatorWarning: "من فضلك ادخل نبذه عنك",
            ),
            SizedBox(
              height: 20,
            ),
            // loading?Center(
            //   child: CircularProgressIndicator(),
            // ):
            _drawSelectServicesForm(),
            (_services.length == 0)
                ? Container()
                : Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _drawSelectedServicesPrice(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _drawDropdownFormField(
              hintTitle: 'الجنس',
              validatorWarning: 'من فضلك اختر الجنس',
              value: _selectedGender,
              items: _gender.map((location) {
                return DropdownMenuItem(
                  child: DrawSingleText(title: location),
                  value: location,
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            DrawSingleTextFormField(
              helperText: 'من فضلك اضغط علي الايقونه لتظهر لك الخريطه',
              helperStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 8,
                color: Theme.of(context).accentColor,
                letterSpacing: 1.5,
              ),
              labelText: 'العنوان',
              labelStyle: TextStyle(
                fontFamily: 'Cairo',
                color: Theme.of(context).primaryColor,
                fontSize: _widgetsSize.small14 - 2,
              ),
              textAlign: TextAlign.end,
              icon: Icons.location_on,
              iconSize: _widgetsSize.small20,
              suffixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: IconButton(
                  iconSize: _widgetsSize.smallLogoIconRadius45,
                  // icon: FlareActor(
                  //   "assets/flare/ces.flr",
                  //   fit: BoxFit.cover,
                  //   animation: "loading",
                  // ),
                  icon: Icon(Icons.person),
                  onPressed: () {
                    if (_title == null) {
                      _drawShowDialog();
                    } else {
                      // openRequestMapScreen('sourcePoint');
                    }
                  },
                ),
              ),
              keyboardType: TextInputType.text,
              secure: false,
              controller: _titleController,
              maxLines: 1,
              validatorWarning: "من فضلك ادخل العنوان",
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSelectServicesForm() {
    return Container(
      child: MultiSelectFormField(
        autovalidate: false,

        title: Text('الخدمات المقدمه'),

        // ignore: missing_return
        validator: (value) {
          if (value == null || value.length == 0) {
            return 'من فضلك اختر خدمه او اكثر';
          }
        },


        dataSource: [
          {
            "display": "_selectCateModel.data[0].categories.name",
            "value": "_selectCateModel.data[0].categories.id",
          },
          {
            "display":"_selectCateModel.data[1].categories.name",
            "value": "_selectCateModel.data[1].categories.id",
          },
          {
            "display":"_selectCateModel.data[2].categories.name",
            "value": "_selectCateModel.data[2].categories.id",
          },
          {
            "display": "_selectCateModel.data[3].categories.name",
            "value": "_selectCateModel.data[3].categories.id",
          },
        ],
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'تاكيد',
        cancelButtonLabel: 'الغاء',
        // required: true,

        hintWidget: Text(" 'من فضلك اختر خدمه او اكثر'"),
        initialValue: _services,

        onSaved: (value) {
          if (value == null) return;
          setState(() {
            _services = value;
          });
        },
      ),
    );
  }

  Widget _drawSelectedServicesPrice() {
    return Container(
      height: screenHeight * 0.25,
      child: ListView.builder(
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              DrawSingleText(
                title: 'سعر الخدمة',
                fontSize: _widgetsSize.small14,
                color: Theme.of(context).primaryColor,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .32,
                    child: DrawSingleTextFormField(
                      labelText: 'المنزل',
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        color: Theme.of(context).primaryColor,
                        fontSize: _widgetsSize.small14,
                      ),
                      textAlign: TextAlign.end,
                      icon: Icons.attach_money,
                      iconSize: _widgetsSize.small20,
                      keyboardType: TextInputType.phone,
                      secure: false,
                      maxLines: 1,
                      validatorWarning: "من فضلك ادخل سعر المنزل",
                      onSaved: (value) {
                        setState(() {
                          _servicePricesh.add(value);
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .32,
                    child: DrawSingleTextFormField(
                      labelText: 'مقدم الخدمة',
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        color: Theme.of(context).primaryColor,
                        fontSize: _widgetsSize.small14 - 2,
                      ),
                      textAlign: TextAlign.end,
                      icon: Icons.attach_money,
                      iconSize: _widgetsSize.small20,
                      keyboardType: TextInputType.phone,
                      secure: false,
                      maxLines: 1,
                      validatorWarning: "من فضلك ادخل سعر العيادة",
                      onSaved: (value) {
                        setState(() {
                          _servicePricesc.add(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
        itemCount: _services.length,
      ),
    );
  }

  Widget _drawDropdownFormField(
      {String hintTitle, String value, items, onChanged, validatorWarning}) {
    return DropdownButtonFormField(
      iconEnabledColor: Theme.of(context).primaryColor,
      style: TextStyle(
        backgroundColor: Colors.transparent,
        color: Theme.of(context).primaryColor,
        fontSize: _widgetsSize.small14 - 4,
      ),
      hint: DrawSingleText(
        title: hintTitle,
        color: Theme.of(context).primaryColor,
        fontSize: _widgetsSize.small14 - 3,
      ),
      decoration: InputDecoration(
        isDense: true,
      ),
      value: value,
      validator: (value) {
        if (value == null) {
          return validatorWarning;
        }
        return null;
      },
      items: items,
      onChanged: onChanged,
    );
  }

  // openRequestMapScreen(String point) async {
  //   CameraPosition _position = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => MapScreen(point)),
  //   );
  //   setState(() {
  //     _lat = lat;
  //     _long = long;
  //   });
  //   List<Placemark> placeMark =
  //   await placemarkFromCoordinates(_lat, _long);
  //
  //   setState(() {
  //     _title = placeMark[0].thoroughfare +
  //         ', ' +
  //         placeMark[0].locality +
  //         ', ' +
  //         placeMark[0].subAdministrativeArea +
  //         ', ' +
  //         placeMark[0].administrativeArea +
  //         ', ' +
  //         placeMark[0].country;
  //   });
  //   _checkPoint();
  // }

  _checkPoint() {
    _titleController =
        TextEditingController(text: _title != null ? _title : "");

    print(_title);
  }

  _drawShowDialog() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DrawSingleText(
                    title: 'من فضلك تأكد آولا من تفعيل اعدادات الموقع',
                    color: Colors.black,
                    fontSize: _widgetsSize.small18,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _drawLocationRaisedButton(),
              ],
            ),
          ],
        ));
  }

  Widget _drawLocationRaisedButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: screenWidth * 0.5,
        child: RaisedButton(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          elevation: 0,
          child: DrawSingleText(
            title: "تفعيل",
            color: Colors.white,
            fontSize: _widgetsSize.small16,
          ),
          onPressed: () {
            // AppSettings.openLocationSettings();
            // Navigator.pop(context);
            // openRequestMapScreen('sourcePoint');
          },
        ),
      ),
    );
  }
}
