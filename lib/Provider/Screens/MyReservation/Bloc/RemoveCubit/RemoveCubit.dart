import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/Bloc/RemoveCubit/RemoveModel.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/Bloc/RemoveCubit/RemoveState.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/controller/controller.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/model/model.dart';
import 'package:lastre3ayty/common/CustomDialog.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveCubit extends Cubit<RemoveState>{
  RemoveCubit() : super(RemoveInitState());

  static RemoveCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  RemoveModel _removeModel;
  Future<void> removeReservation(BuildContext context) async {
    emit(RemoveLoadingState());

    try{
      final url = "https://mycare.pro/api/removereservation";
      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "reservation_id" : "${_pref.getInt("res_id")}",
      });

      Map<String, dynamic> header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${_pref.get("api_token")}",
      };

      final Response response = await dio.post(url, data: formData, options: Options(headers: header));


      if(response.statusCode == 200 && response.data["msg"] == "success"){

        _removeModel = RemoveModel.fromJson(response.data);
        showDialog(context: context, builder: (_){
          return CustomDialog(msg: "تم الحذف بنجاح", navRoute: ()=> Navigator.pop(_));
        });
        // isLoading=true;
        // getReservation();
        emit(RemoveSuccessState());

      } else if (response.statusCode == 200 && response.data["msg"] != "success"){
        emit(RemoveErrorState(response.data["msg"]),);
        print("اوعى الايرور يا عم الحاج");
      }

    }catch (e) {
      if (e.response != null){
        emit(RemoveErrorState(e));
        print("اعاااااااااا");
      }
    }
  }


  bool isLoading = true;
  ReversationsModel reversationsModel =ReversationsModel();
  NetworkUtil util = NetworkUtil();
  Future<void> getReservation() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_pref.get("api_token")}",
    };

    final data = await util.get("ownerreservation", headers: header);
    if (data == null) {
      reversationsModel = null;
      return reversationsModel;
    } else {
      reversationsModel = ReversationsModel.fromJson(data.data);
      print(data.data);
      isLoading = false;
      emit(GetReservationSuccessState());
      // return reversationsModel;
    }
  }

}