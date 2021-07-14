import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Item.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Items.dart';
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Main_Drawer.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_Cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_Cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_State.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomSection.dart';

class ProviderDrawerWidget extends StatefulWidget {
  final ValueChanged<ProviderDrawerItem> onSelectedItem;

  ProviderDrawerWidget({@required this.onSelectedItem});

  @override
  _ProviderDrawerWidgetState createState() => _ProviderDrawerWidgetState();
}

class _ProviderDrawerWidgetState extends State<ProviderDrawerWidget> {
  ProviderProfileCubit cubit = ProviderProfileCubit();

  @override
  void initState() {
    cubit.providerProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
      listener: (_, state){},
      builder: (context, state){
        return Directionality(
          textDirection: TextDirection.rtl,
          child: state is ProviderProfileLoadingState
              ? CenterLoading()
              : Container(
                  padding: EdgeInsets.only(top: 0, left: 15, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //============== provider information =================
                        providerInformation(context),

                        //============== drawer cat =================
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 8,
                              top: MediaQuery.of(context).size.height * 0.05,
                          ),
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
      children: ProviderDrawerItems.all.map((item) => CustomSection(
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

  Widget providerInformation(BuildContext context){
    final editCubit = EditProviderCubit.get(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProviderMainDrawer(
              appBarTitle: "الصفحة الشخصية",
              index: 1,
              providerProfileCubit: cubit,
            ),
          ),
        );
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
                child: editCubit.image == null
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://mycare.pro/public/dash/assets/img/${cubit.providerProfileModel.data.image}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Image.file(editCubit.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    editCubit.name == null ? "${cubit.providerProfileModel.data.name}" : "${editCubit.name}",
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, fontFamily: "Cairo-Bold"),
                  ),
                  Text(
                    editCubit.phone == null ? "${cubit.providerProfileModel.data.phone}" : "+966${editCubit.phone}",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Colors.white, fontSize: 14),
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

