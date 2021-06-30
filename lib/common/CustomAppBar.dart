import 'package:flutter/material.dart';
import 'package:lastre3ayty/User/screens/Notification/Notification_Screen.dart';
import 'package:lastre3ayty/User/screens/Search/Search.dart';
import 'package:lastre3ayty/theme/color.dart';

Widget customAppBar({
  @required BuildContext context,
  @required String appBarTilte,
  final bool showDrawerIcon = false,
  final bool showSearchIcon = false,
  final bool showNotificationIcon = false,
  Function onPressedDrawer,
  Widget otherIconWidget,
  Function onTapOtherIcon,
  Function onTapSearchIcon,
  Function onTapNotification,
}) {
  return AppBar(
    backgroundColor: ThemeColor.greyText,
    elevation: 3,
    titleSpacing: 0,
    leadingWidth: 50,
    centerTitle: false,
    leading: showDrawerIcon == true
        ? drawerIcon(
            context: context,
            onPressed: onPressedDrawer,
            color: Theme.of(context).primaryColor,
          )
        : InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(right: 15, top: 15, bottom: 15),
              child: Icon(Icons.arrow_back_ios,
                  size: 18, color: Theme.of(context).primaryColor),
            ),
          ),
    title: Text(
      appBarTilte,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 15,
        color: Theme.of(context).primaryColor,
        fontFamily: 'Cairo-Bold',
      ),
    ),
    actions: [
      showSearchIcon == true
          ? InkWell(
              child: Container(
                  //width: 20,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Image.asset(
                    "assets/icons/search.png",
                    color: Theme.of(context).primaryColor,
                    fit: BoxFit.fill,
                  ),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => Search()));
              },
            )
          : Container(),
      showNotificationIcon == true
          ? InkWell(
              child: Container(
                width: 20,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 17.5),
                child: Image.asset(
                  "assets/icons/notifi.png",
                  color: Theme.of(context).primaryColor,
                  fit: BoxFit.fill,
                ),
              ),
              onTap: onTapNotification,
            )
          : Container(),
      SizedBox(width: 8),
    ],
  );
}

Widget drawerIcon({
  BuildContext context,
  Function onPressed,
  Color color,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 20,
      margin: EdgeInsets.only(right: 5, top: 16, bottom: 16),
      child: Center(
        child: Image.asset(
          "assets/icons/menu.png",
          color: Theme.of(context).primaryColor,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
