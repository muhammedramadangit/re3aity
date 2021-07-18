import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/CustomDrawer/Main_Drawer.dart';
import 'package:lastre3ayty/User/models/Category_model/All_category.dart';
import 'package:lastre3ayty/User/models/Category_model/Category_data.dart';
import 'package:lastre3ayty/User/screens/Notification/Firebase_Notification/Firebase_notification_handler.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:lastre3ayty/User/screens/Sections/Controller/SectionController.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomSection.dart';

class Sections extends StatefulWidget {
  final Function openDrawer;
  final bool skip;

  const Sections({Key key, @required this.openDrawer, this.skip}) : super(key: key);

  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  bool _isLoading = true;
  AllCategories _allCategories = AllCategories();
  SectionController _sectionController = SectionController();
  // List<CategoryData> categories;
  List<String> _catImages = [
    'assets/icons/page.png', //خدمات منزلية
    'assets/icons/xzxdoc.png', //تنظيف
    'assets/icons/spa.png', //كهرباء
    'assets/icons/asasahospital.png', //سباكة
  ];
  final cubit = ProfileCubit();

  void getCat() async {
    _allCategories = await _sectionController.getSection();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    cubit.getProfile();
    getCat();
    FireBaseNotifications().setUpFireBase(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //============ Logo Position ===========
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8, bottom: 10),
                child: AnimatedWidgets(
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
              ),

              //============ Choose Section =============
              Expanded(
                child: _isLoading
                    ? CenterLoading()
                    : chooseCategory(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chooseCategory(BuildContext context){
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 35, horizontal: 35),
      itemCount: _allCategories.data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return AnimatedWidgets(
          duration: 1.5,
          horizontalOffset: 0,
          virticaloffset: 150,
          child: CustomSection(
            title: _allCategories.data[index].categories.name,
            imgSrc: _catImages[index],
            fit: BoxFit.fill,
            imgSize: 70,
            onTap: () {
              print("indexxxxxxxxxxxxxxxx ${index}");
              print("ID++++++++++++++++++ ${_allCategories.data[index].categories.id}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MainDrawer(
                    skip: widget.skip,
                    appBarTitle: _allCategories.data[index].categories.name,
                    index: 0,
                    id: _allCategories.data[index].categories.id,
                    categoryData: _allCategories.data[index],
                    sectionServiceName: _allCategories.data[index].categories.name,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
