import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/screens/Profile/Edit_Profile/Edit_Profile.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/Controller/ProfileController.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/model/ProfileModel.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/theme/color.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isloading = true;
  ProfileModel _profileModel = ProfileModel();
  ProfileController _profileController = ProfileController();

  void postProfile() async {
    _profileModel = await _profileController.postProfile();
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 20),
          child: _isloading? CenterLoading() : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //============== profile information card ====================
                AnimatedWidgets(
                  duration: 1.5,
                  virticaloffset: 0,
                  horizontalOffset: 50,
                  child: CustomCard(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EditProfile(profileModel: _profileModel,))),
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                  "https://mycare.pro/public/dash/assets/img/${_profileModel.data.image}"),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profileModel.data.name.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 14,
                                    fontFamily: "Cairo-Bold"),
                              ),
                              Text(
                                _profileModel.data.phone.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset("assets/icons/setting.png",
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.cover,
                                    color: Theme.of(context).accentColor),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //=============== Location Card =================
                AnimatedWidgets(
                  duration: 1.5,
                  virticaloffset: 0,
                  horizontalOffset: 50,
                  child: CustomCard(
                    height: MediaQuery.of(context).size.height / 7,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الموقع",
                              style: TextStyle(
                                  color: ThemeColor.greyText, fontSize: 14),
                            ),
                            Text(
                              _profileModel.data.address.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedWidgets(
                      duration: 1.5,
                      virticaloffset: 50,
                      horizontalOffset: 0,
                      child: CustomButton(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        text: "حفظ",
                        bottomPadding: 10,
                        topPadding: 10,
                        rightPadding: 0,
                        leftPadding: 0,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
