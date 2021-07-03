import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Controller/SelectCateController.dart';
import 'package:lastre3ayty/Provider/Models/SelectCateModel.dart';
import 'package:lastre3ayty/User/CustomDrawer/Main_Drawer.dart';
import 'package:lastre3ayty/User/screens/Doctors/Doctors.dart';
import 'package:lastre3ayty/User/screens/Electricity/Electricity.dart';
import 'package:lastre3ayty/User/screens/Home_Services/Home_Services.dart';
import 'package:lastre3ayty/User/screens/Plumbing/Plumbing.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomSection.dart';

class Sections extends StatefulWidget {
  final Function openDrawer;

  const Sections({Key key, @required this.openDrawer}) : super(key: key);

  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
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
          child:   SingleChildScrollView(
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
               loading?Text("m"): Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: 50,
                        virticaloffset: 0,
                        child: CustomSection(
                          title: "طبيب",
                          imgSrc: "assets/icons/asasahospital.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MainDrawer(appBarTitle: "أطباء", index: 0)));
                          },
                        ),
                      ),
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: -50,
                        virticaloffset: 0,
                        child: CustomSection(
                          title: "خدمات منزلية",
                          imgSrc: "assets/icons/spa.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MainDrawer(appBarTitle: "خدمات منزلية", index: 1)));
                          },
                        ),
                      ),
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: 50,
                        virticaloffset: 0,
                        child: CustomSection(
                          title: "سباكة",
                          imgSrc: "assets/icons/doc.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MainDrawer(appBarTitle: "سباك", index: 2)));
                          },
                        ),
                      ),
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: -50,
                        virticaloffset: 0,
                        child: CustomSection(
                          title: "كهرباء",
                          imgSrc: "assets/icons/xzxdoc.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MainDrawer(appBarTitle: "كهرباء", index: 3)));
                          },
                        ),
                      ),
                    ],
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

