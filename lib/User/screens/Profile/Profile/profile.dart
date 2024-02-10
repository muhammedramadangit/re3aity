import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Profile/Edit_Profile/Edit_Profile.dart';
import 'package:re3aity/User/screens/Profile/Edit_Profile/bloc/Edit_Cubit.dart';
import 'package:re3aity/User/screens/Profile/Profile/Bloc/ProfileCubit.dart';
import 'package:re3aity/User/screens/Profile/Profile/Bloc/ProfileState.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CustomCard.dart';
import 'package:re3aity/theme/color.dart';

class Profile extends StatefulWidget {
  final ProfileCubit? profileCubit;

  const Profile({Key? key, this.profileCubit}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
        listener: (_, state) {},
        builder: (context, state) {
          return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    body: Padding(
                      padding: EdgeInsets.only(right: 15, left: 15, top: 20),
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

  //================================= profile information card =======================================
  Widget profileInformation(BuildContext context) {
    final editedCubit = EditProfileCubit.get(context);
    return AnimatedWidgets(
      duration: 1.5,
      virticaloffset: 0,
      horizontalOffset: 50,
      child: CustomCard(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfile(profilecubit: widget.profileCubit))),
        height: MediaQuery.of(context).size.height / 6.5,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 4,
                  child: editedCubit.image == null ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://my-care.life/public/dash/assets/img/${widget.profileCubit!.profileModel!.data!.image}"),
                          fit: BoxFit.cover,
                        )),
                  ): Image.file(editedCubit.image!, fit: BoxFit.cover)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    editedCubit.name == null
                        ? "${widget.profileCubit!.profileModel!.data!.name}"
                        : "${editedCubit.name}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                        fontFamily: "Cairo-Bold"),
                  ),
                  Text(
                    editedCubit.phone == null
                        ? "${widget.profileCubit!.profileModel!.data!.phone}"
                        : "+966${editedCubit.phone}",
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

  //======================================= Location Card =============================================
  Widget locationCard(BuildContext context){
    final editedCubit = EditProfileCubit.get(context);
    return AnimatedWidgets(
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
              editedCubit.address == null
                  ? "${widget.profileCubit!.profileModel!.data!.address}"
                  : "${editedCubit.address}",
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
