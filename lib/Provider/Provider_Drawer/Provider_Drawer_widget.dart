import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Item.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Items.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:lastre3ayty/common/CustomSection.dart';

class ProviderDrawerWidget extends StatelessWidget {
  final ValueChanged<ProviderDrawerItem> onSelectedItem;

  ProviderDrawerWidget({Key key, @required this.onSelectedItem}) : super(key: key);

  //Profile _profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(top: 0, left: 15, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderMainDrawer(appBarTitle: "الصفحة الشخصية", index: 1)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/doctor.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "محمد رمضان",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14, fontFamily: "Cairo-Bold"),
                            ),
                            Text(
                              "123123123",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8, top: MediaQuery.of(context).size.height *0.05),
                child: buildDrawerItems(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context){
    return Column(
      children: ProviderDrawerItems.all.map((item) => CustomSection(
        height: 95,
        width: 100,
        verticalPadding: 4,
        color: Colors.white,
        imgSize: 50,
        fontSize: 12,
        title: item.title,
        imgSrc: item.imgSrc,
        onTap: () => onSelectedItem(item),
      )).toList(),
    );
  }
}

