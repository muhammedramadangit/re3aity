import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Doctors/Bloc/AddReservationState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReservationCubit extends Cubit<AddReservationState>{
  AddReservationCubit() : super(AddReservationInitState());

  static AddReservationCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String date, time, place;
  int user_id, owner_id, cat_id;

  Future<void> postAddReservation() async {
    emit(AddReservationLoadingState());

    try{
      print("user ID : ${user_id.toString()}");
      print("owner ID : ${owner_id.toString()}");
      print("cat ID : ${cat_id.toString()}");
      print("date : $date");
      print("time : $time");
      print("place : $place");
      final url = "https://mycare.pro/api/addreservation";
      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "user_id" : "${_pref.getInt("user_id")}",
        "owner_id" : "${_pref.getInt("pro_id")}",
        // "cat_id" : "${_pref.getInt("cat_id")}",
        "cat_id" : 1,
        "date" : date,
        "time" : time,
        "place" : place,
      });

      Map<String, dynamic> headers = {
        "Accept" : "application/json",
        "Content-Type" : "application/json",
        "Authorization" : "Bearer ${_pref.getString("api_token")}",
      };

      final Response response = await dio.post(url, data: formData, options: Options(headers: headers));

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(AddReservationSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        print("<<<<<<<<<  STATE ERROR  >>>>>>>>>");
        emit(AddReservationErrorState(response.data["msg"]));
      }

    }catch(e){
      if(e.response != null){
        print("<<<<<<<<<<<<< CATCH ERROR >>>>>>>>>>>>>");
        emit(AddReservationErrorState(e));
      }
    }
  }
}