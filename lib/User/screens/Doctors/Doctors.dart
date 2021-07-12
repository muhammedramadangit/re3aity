import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/models/Category_model/All_category.dart';
import 'package:lastre3ayty/User/models/Category_model/user.dart';
import 'package:lastre3ayty/User/screens/Doctors/Doctors_Item.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CenterMessage.dart';

class Doctors extends StatefulWidget {
  final AllCategories allCategories;
  final String serviceName;
  final int id;
  const Doctors({this.allCategories, this.serviceName, this.id});

  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _searchName;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < widget.allCategories.data[widget.id].subcategories.length; i++){
      users.add(widget.allCategories.data[widget.id].subcategories[i].user);
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Cat ID ========>> ${widget.id}");
    print("subcategories length ................. ${widget.allCategories.data[widget.id].subcategories.length}");
    print("name>>>>>>>>>>>>>>> ${widget.allCategories.data[widget.id].categories.name}");
    var filteredList = users.where((User item) {
      if(_searchName == null){
        return true;
      }else{
        return item.name.contains(_searchName);
      }
    }).toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        body: _isLoading
            ? CenterLoading()
            : (users.length == 0 || users.isEmpty)
                ? CenterMessage(msg: "القائمة فارغة")
                : Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(right: 15, left: 15, top: 10),
                    child: ListView.builder(
                      itemCount: widget.allCategories.data[widget.id].subcategories.length,
                      itemBuilder: (_, index) {
                        var item = filteredList[index];
                        return AnimatedWidgets(
                          duration: 1.5,
                          virticaloffset: 50,
                          horizontalOffset: 0,
                          child: DoctorsItem(
                            subcategories: widget.allCategories.data[widget.id].subcategories[index],
                            name: item.name,
                            imgSrc: item.image,
                            rate: item.rate,
                            description:item.desc,
                            catID: widget.allCategories.data[widget.id].categories.id,
                            serviceName: widget.serviceName,
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