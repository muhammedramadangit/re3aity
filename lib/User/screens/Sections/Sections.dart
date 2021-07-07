import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/CustomDrawer/Main_Drawer.dart';
import 'package:lastre3ayty/User/screens/Sections/Controller/SectionController.dart';
import 'package:lastre3ayty/User/screens/Sections/model/SectionModel.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomSection.dart';

class Sections extends StatefulWidget {
  final Function openDrawer;

  const Sections({Key key, @required this.openDrawer}) : super(key: key);

  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  bool _isLoading = true;
  SectionModel _sectionModel = SectionModel();
  SectionController _sectionController = SectionController();
  List<String> _catImages = [
    'assets/icons/page.png',
    'assets/icons/xzxdoc.png',
    'assets/icons/spa.png',
    'assets/icons/asasahospital.png',
  ];

  void getCat() async {
    _sectionModel = await _sectionController.getSection();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getCat();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //============ Logo Position ===========
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8, bottom: 10),
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
                Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: _isLoading
                      ? CenterLoading()
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          itemCount: _sectionModel.data.length,
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
                                title: _sectionModel.data[index].categories.name,
                                imgSrc: _catImages[index],
                                fit: BoxFit.fill,
                                imgSize: 70,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MainDrawer(
                                                appBarTitle: _sectionModel.data[index].categories.name,
                                                index: 0,
                                                sectionModel: _sectionModel,
                                              ),
                                      ),
                                  );
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
    );
  }
}
