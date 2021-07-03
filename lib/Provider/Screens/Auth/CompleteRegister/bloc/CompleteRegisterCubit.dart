import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteRegisterCubit extends Cubit<CompleteRegisterState>{
  CompleteRegisterCubit() : super(CompleteRegisterInitState());

  static CompleteRegisterCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String user_id, sex, lat, lng, address, name, desc;
  List catIds;
  List homePrices = [];
  List clinicPrices = [];
  List categories = [];

  Future<void> postCompleteRegister() async {

    emit(CompleteRegisterLoadingState());

    try{

      print("sex : $sex | "
          "lat : $lat | "
          "lng : $lng |"
          " address : $address"
          " | name : $name | "
          "desc : $desc |"
          " categories : $categories "
          "| user ID : $user_id");
      final url = "https://mycare.pro/api/completeadvertiserdata";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      print( _pref.getInt("id"));
      print(categories);
      final body = {
        "user_id" : _pref.getInt("id"),
        "sex" : sex,
        "lat" : lat,
        "lng" : lng,
        "address" : address,
        "name" : name,
        "desc" : desc,
        'categories': jsonEncode({"categories": categories}),
      };
      FormData formData = FormData.fromMap(body);
// print(body);
      // return;
      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(CompleteRegisterSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(CompleteRegisterErrorState(response.data["msg"]));
        print("يا عممممممممممممممممممم");
      }

    }catch(e){
      if(e.response != null){
        print("يلا يا نجم");
        emit(CompleteRegisterErrorState(e.toString()));
        CompleteRegisterInitState();
      }
    }
  }
}

