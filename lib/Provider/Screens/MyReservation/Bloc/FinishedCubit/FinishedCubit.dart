import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/Bloc/FinishedCubit/FinishedModel.dart';
import 'package:lastre3ayty/Provider/Screens/MyReservation/Bloc/FinishedCubit/FinishedState.dart';
import 'package:lastre3ayty/common/CustomDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinishedCubit extends Cubit<FinishedState>{
  FinishedCubit() : super(FinishedInitState());

  static FinishedCubit get(context) => BlocProvider.of(context);
  bool isLoading = true;
  Dio dio = Dio();
  FinishedModel finishedModel;
  Future<void> finishedReservation(BuildContext context) async {
    emit(FinishedLoadingState());

    try{
      final url = "https://mycare.pro/api/upreservationtype";
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
        isLoading = false;
        finishedModel = FinishedModel.fromJson(response.data);
        showDialog(context: context, builder: (_){
          return CustomDialog(msg: "تم الإنهاء بنجاح", navRoute: ()=> Navigator.pop(_));
        });
        emit(FinishedSuccessState());

      } else if (response.statusCode == 200 && response.data["msg"] != "success"){
        emit(FinishedErrorState(response.data["msg"]),);
        print("اوعى الايرور يا عم الحاج");
      }

    }catch (e) {
      if (e.response != null){
        emit(FinishedErrorState(e));
        print("اعاااااااااا");
      }
    }
  }
}