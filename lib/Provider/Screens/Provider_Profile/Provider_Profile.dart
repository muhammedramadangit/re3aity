import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Bloc/ProviderProfileCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Edit_Provider_Profile.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomCard.dart';
import 'package:lastre3ayty/theme/color.dart';

class ProviderProfile extends StatefulWidget {
  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProviderProfileCubit.get(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 10),
          child: Container(
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
                        MaterialPageRoute(builder: (_) => EditProviderProfile())),
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: Row(
                      children: [

                        //================== profile image =================
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/doctor.jpg"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),

                        //================== profile data ==================
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "محمد رمضان",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 14,
                                    fontFamily: "Cairo-Bold"),
                              ),
                              Text(
                                "123123123",
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
                              "جدة، العزيزية، شارع الملك فهد 12345",
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
                                Icon(Icons.arrow_forward_ios,
                                    color: Theme.of(context).accentColor)
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
