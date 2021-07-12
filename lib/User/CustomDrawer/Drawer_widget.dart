import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/CustomDrawer/Drawer_Item.dart';
import 'package:lastre3ayty/User/CustomDrawer/Drawer_Items.dart';
import 'package:lastre3ayty/User/CustomDrawer/Main_Drawer.dart';
import 'package:lastre3ayty/User/screens/Profile/Edit_Profile/bloc/Edit_Cubit.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/Bloc/ProfileState.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomSection.dart';

class DrawerWidget extends StatefulWidget {
  final ValueChanged<DrawerItem> onSelectedItem;

  DrawerWidget({Key key, @required this.onSelectedItem}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  ProfileCubit cubit = ProfileCubit();

  @override
  void initState() {
    cubit.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (_, state){},
      builder: (context, state){
        return state is ProfileLoadingState
        ? CenterLoading() : Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(top: 0, left: 15, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //============== user information =================
                  userInformation(context),

                  //============== drawer cat ==================
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8),
                    child: buildDrawerItems(context),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDrawerItems(BuildContext context){
    return Column(
      children: DrawerItems.all.map((item) => CustomSection(
        height: 95,
        width: 100,
        verticalPadding: 4,
        color: Colors.white,
        imgSize: 50,
        fontSize: 12,
        title: item.title,
        imgSrc: item.imgSrc,
        onTap: () => widget.onSelectedItem(item),
      )).toList(),
    );
  }

  Widget userInformation(BuildContext context) {
    final editedCubit = EditProfileCubit.get(context);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MainDrawer(
                    showSearchIcon: false,
                    appBarTitle: "الصفحة الشخصية",
                    index: 1,
                    profileCubit: cubit,
                  ))),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: editedCubit.image == null
                      ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://mycare.pro/public/dash/assets/img/${cubit.profileModel.data.image}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    : Image.file(editedCubit.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cubit.profileModel.data.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "Cairo-Bold"),
                  ),
                  Text(
                    cubit.profileModel.data.phone,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

