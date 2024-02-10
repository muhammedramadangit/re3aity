import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:re3aity/Provider/Screens/MyReservation/Bloc/FinishedCubit/FinishedCubit.dart';
import 'package:re3aity/Provider/Screens/MyReservation/Bloc/RemoveCubit/RemoveCubit.dart';
import 'package:re3aity/Provider/Screens/MyReservation/ProviderReservationItem.dart';
import 'package:re3aity/Provider/Screens/MyReservation/controller/controller.dart';
import 'package:re3aity/Provider/Screens/MyReservation/model/model.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/common/CenterLoading.dart';

class ProviderReservation extends StatefulWidget {
  @override
  _ProviderReservationState createState() => _ProviderReservationState();
}

class _ProviderReservationState extends State<ProviderReservation> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _isLoading = true;
  // ReversationsModel _reversationsModel = ReversationsModel();

  // ReservationController _reservationController = ReservationController();
  //
  // void _getReservation() async {
  //   _reversationsModel = await _reservationController.getReservation();
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  void initState() {
    final cubit = RemoveCubit.get(context);
    cubit.getReservation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = RemoveCubit.get(context);
    final finishedCubit = FinishedCubit.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        // body: cubit.isLoading || finishedCubit.isLoading
        //     ? CenterLoading()
        //    :
        body: cubit.reversationsModel.data == null
                ? Center(
                    child: Text(
                      "لا يوجد حجوزات",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(right: 15, left: 15, top: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: cubit.reversationsModel.data!.length,
                      itemBuilder: (ctx, index) {
                        return AnimatedWidgets(
                          duration: 1.5,
                          virticaloffset: 50,
                          horizontalOffset: 0,
                          child: Slidable(
                            actionPane: SlidableBehindActionPane(),
                            actionExtentRatio: 0.25,
                            actions: [removedButton(ctx)],
                            secondaryActions: [finishedButton(ctx)],
                            child: ProviderReservationItem(
                              imgSrc: cubit.reversationsModel.data![index]!.image ?? "",
                              name: cubit.reversationsModel.data![index]!.userName ?? "",
                              gender: cubit.reversationsModel.data![index]!.sex ?? "",
                              phone: cubit.reversationsModel.data![index]!.phone ?? "",
                              date: cubit.reversationsModel.data![index]!.date ?? "",
                              time: cubit.reversationsModel.data![index]!.time ?? "",
                              location: cubit.reversationsModel.data![index]!.place ?? "",
                              resID: cubit.reversationsModel.data![index]!.reservationId!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  //============================= remove button ====================================
  Widget removedButton(BuildContext context){
    final cubit = RemoveCubit.get(context);
    return IconSlideAction(
      iconWidget: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: (){
            cubit.removeReservation(context).then((value) => cubit.getReservation());
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Image.asset(
                "assets/icons/delete.png",
                height: 40,
                width: 40,
                color: Colors.white,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //============================ finished button ===================================
  Widget finishedButton(BuildContext context){
    final finishedCubit = FinishedCubit.get(context);
    final cubit = RemoveCubit.get(context);
    return IconSlideAction(
      iconWidget: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: (){
            finishedCubit.finishedReservation(context).then((value) => cubit.getReservation());
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/done.png",
                  color: Colors.white,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
                Text(
                  "إنهاء",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
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
