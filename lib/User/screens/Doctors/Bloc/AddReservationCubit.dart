import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Doctors/Bloc/AddReservationState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReservationCubit extends Cubit<AddReservationState>{
  AddReservationCubit() : super(AddReservationInitState());

  static AddReservationCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String user_id, owner_id, cat_id, date, time, place;

  Future<void> postAddReservation() async {
    emit(AddReservationLoadingState());

    try{
      print("user ID : $user_id | owner ID : $owner_id | cat ID : $cat_id | date : $date | time : $time | place : $place");
      final url = "https://mycare.pro/api/addreservation";
      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "user_id" : "${_pref.getString("user_id")}",
        "owner_id" : "${_pref.getString("pro_id")}",
        "cat_id" : "3",
        "date" : "2021-07-20",
        "time" : "6:43 PM",
        "place" : "العيادة",
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