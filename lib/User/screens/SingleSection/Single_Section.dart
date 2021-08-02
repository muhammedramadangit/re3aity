import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/models/Category_model/All_category.dart';
import 'package:lastre3ayty/User/models/Category_model/Category_data.dart';
import 'package:lastre3ayty/User/models/Category_model/user.dart';
import 'package:lastre3ayty/User/screens/Sections/Controller/SectionController.dart';
import 'package:lastre3ayty/User/screens/SingleSection/Single_Section_Item.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CenterMessage.dart';

class SingleSection extends StatefulWidget {
  final CategoryData categoryData;
  final String serviceName;
  final int id;
  final bool skip;
  const SingleSection({this.serviceName, this.id, this.categoryData, this.skip});

  @override
  _SingleSectionState createState() => _SingleSectionState();
}

class _SingleSectionState extends State<SingleSection> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SectionController sectionController = SectionController();
  AllCategories allCategories = AllCategories();
  List<User> users = [];

  void getDoctor() async {
    allCategories = await sectionController.getSection();
    setState(() {
      sectionController.isLoading = false;
    });
  }

  @override
  void initState() {
    getDoctor();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        body: sectionController.isLoading
            ? CenterLoading()
            : (widget.categoryData.subcategories.length == 0)
                ? CenterMessage(msg: "القائمة فارغة")
                : Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(right: 15, left: 15, top: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.categoryData.subcategories.length,
                      itemBuilder: (_, index) {
                        var item = widget.categoryData.subcategories[index].user;
                        return AnimatedWidgets(
                          duration: 1.5,
                          virticaloffset: 50,
                          horizontalOffset: 0,
                          child: SingleSectionItem(
                            subcategories: widget.categoryData.subcategories[index],
                            providerID: widget.categoryData.subcategories[index].user.id,
                            name: item.name??"",
                            imgSrc: item.image??"",
                            rate: item.rate??"",
                            description:item.desc??"",
                            catID: widget.id??"",
                            serviceName: widget.serviceName??"",
                            skip: widget.skip,
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

// floatingActionButton: UnicornDialer(
//   hasBackground: false,
//   orientation: UnicornOrientation.VERTICAL,
//   parentButton: Icon(Icons.add_circle_outline, color: Colors.white, size: 25),
//   parentButtonBackground: Theme.of(context).accentColor,
//   animationDuration: 1,
//   childButtons: [
//     UnicornButton(
//       currentButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         mini: true,
//         child: Image.asset("assets/icons/profile.png", color: Colors.white, height: 20, width: 20, fit: BoxFit.cover),
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
//         },
//       ),
//     ),
//
//     UnicornButton(
//       currentButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         mini: true,
//         child: Image.asset("assets/icons/location.png", color: Colors.white, height: 20, width: 20, fit: BoxFit.cover),
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
//         },
//       ),
//     ),
//
//   ],
// ),