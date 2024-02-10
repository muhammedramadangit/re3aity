import 'package:flutter/material.dart';
import 'package:re3aity/User/CustomDrawer/Main_Drawer.dart';
import 'package:re3aity/User/models/Category_model/All_category.dart';
import 'package:re3aity/User/screens/Notification/Firebase_Notification/Firebase_notification_handler.dart';
import 'package:re3aity/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:re3aity/User/screens/Sections/Controller/SectionController.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';
import 'package:re3aity/common/CustomSection.dart';

class Sections extends StatefulWidget {
  final Function? openDrawer;
  final bool? skip;

  const Sections({Key? key, @required this.openDrawer, required this.skip}) : super(key: key);

  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  bool _isLoading = true;
  AllCategories _allCategories = AllCategories();
  SectionController _sectionController = SectionController();
  List<String> _catImages = [
    'assets/icons/asasahospital.png', //'assets/icons/homeservise.png', //خدمات منزلية
    'assets/icons/hospital.png', //'assets/icons/clean.png', //تنظيف
    'assets/icons/page.png', //'assets/icons/ele.png', //كهرباء
    'assets/icons/xzxdoc.png', //'assets/icons/plumb.png', //سباكة
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
      itemCount: _allCategories.data!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, item) {
        return AnimatedWidgets(
          duration: 1.5,
          horizontalOffset: 0,
          virticaloffset: 150,
          child: CustomSection(
            title: _allCategories.data![item]!.categories!.name,
            imgSrc: _catImages[item],
            fit: BoxFit.fill,
            imgSize: 70,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MainDrawer(
                    skip: widget.skip,
                    appBarTitle: _allCategories.data![item]!.categories!.name,
                    id: _allCategories.data![item]!.categories!.id,
                    categoryData: _allCategories.data![item],
                    sectionServiceName: _allCategories.data![item]!.categories!.name,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Widget listCategory(BuildContext context){
  //   return ListView.builder(
  //     physics: BouncingScrollPhysics(),
  //     itemCount: _allCategories.data.length,
  //     itemBuilder: (context, index) {
  //       return AnimatedWidgets(
  //         duration: 1.5,
  //         horizontalOffset: 0,
  //         virticaloffset: 150,
  //         child: CustomSectionButton(
  //           rightside: index.isEven ? true : false,
  //           text: _allCategories.data[index].categories.name,
  //           imgSrc: _catImages[index],
  //           fit: BoxFit.fill,
  //           imgSize: 70,
  //           onTap: () {
  //             print("indexxxxxxxxxxxxxxxx ${index}");
  //             print("ID++++++++++++++++++ ${_allCategories.data[index].categories.id}");
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (_) => MainDrawer(
  //                   skip: widget.skip,
  //                   appBarTitle: _allCategories.data[index].categories.name,
  //                   index: 0,
  //                   id: _allCategories.data[index].categories.id,
  //                   categoryData: _allCategories.data[index],
  //                   sectionServiceName:
  //                   _allCategories.data[index].categories.name,
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
}