import 'package:flutter/material.dart';
import 'package:re3aity/User/models/Category_model/Category_data.dart';
import 'package:re3aity/User/screens/Notification/Notification_Screen.dart';
import 'package:re3aity/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:re3aity/User/screens/Profile/Profile/profile.dart';
import 'package:re3aity/User/screens/SingleSection/Single_Section.dart';
import 'package:re3aity/common/CustomAppBar.dart';


class SectionPage extends StatefulWidget {
  final VoidCallback? openDrawer;
  final int? index, id;
  final String? appBarTitle, serviceName;
  final bool? showSearchIcon, skip;
  final CategoryData? categoryData;
  final ProfileCubit? profileCubit;

  const SectionPage(
      {Key? key,
      @required this.openDrawer,
      this.index,
      this.appBarTitle,
      this.showSearchIcon = true,
      this.categoryData,
      this.serviceName, this.id, this.profileCubit, this.skip})
      : super(key: key);

  @override
  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  var pages = [];
  int _selectedIndex = 0;

  whichPage() {
    if (widget.index == null) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
  }

  @override
  void initState() {
    pages = [
      SingleSection(categoryData: widget.categoryData, serviceName: widget.serviceName, id: widget.id,skip: widget.skip),
      Profile(profileCubit: widget.profileCubit),
    ];
    whichPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          appBarTilte: widget.appBarTitle,
          // showSearchIcon: widget.showSearchIcon,
          // onTapSearchIcon: () {},
          showNotificationIcon: true,
          onTapNotification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage(skip: widget.skip!))),
          showDrawerIcon: true,
          onPressedDrawer: () {
            widget.openDrawer!();
          }
      ),
      body: pages[_selectedIndex],
    );
  }
}