import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_Cubit.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Edit_Profile/Edit_Provider_Profile.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_Cubit.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_State.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CustomCard.dart';
import 'package:re3aity/theme/color.dart';

class ProviderProfile extends StatefulWidget {
  final ProviderProfileCubit? providerProfileCubit;

  ProviderProfile({this.providerProfileCubit});

  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
      listener: (_, state){},
      builder: (context, state){
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
                    profileInformation(context),
                    locationCard(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //======================== profile information card ==========================
  Widget profileInformation(BuildContext context){
    final editCubit = EditProviderCubit.get(context);
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditProviderProfile(profileCubit: widget.providerProfileCubit))),
        height: MediaQuery.of(context).size.height / 6.5,
        child: Row(
          children: [
            //================== profile image =================
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 4,
                child: editCubit.image == null ? Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://my-care.life/public/dash/assets/img/${widget.providerProfileCubit?.providerProfileModel?.data?.image}"),
                        fit: BoxFit.cover,
                      )),
                ): Image.file(editCubit.image!, fit: BoxFit.cover)
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
                    editCubit.name == null
                        ? "${widget.providerProfileCubit!.providerProfileModel!.data!.name}"
                        : "${editCubit.name}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                        fontFamily: "Cairo-Bold"),
                  ),
                  Text(
                    editCubit.phone == null
                        ? "${widget.providerProfileCubit!.providerProfileModel!.data!.phone}"
                        : "+966${editCubit.phone}",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.secondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //============================= Location Card ================================
  Widget locationCard(BuildContext context){
    final editCubit = EditProviderCubit.get(context);
    return  AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الموقع",
              style: TextStyle(
                color: ThemeColor.greyText,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              editCubit.address == null
                  ? "${widget.providerProfileCubit!.providerProfileModel!.data!.address}"
                  : "${editCubit.address}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
