import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatyPrice {
 const  CatyPrice({this.catId,this.price,this.priceHome});
  final int? catId;
  final String? price;
  final String? priceHome;

  CatyPrice copyWith({
     int? catId,
     String? price,
     String? priceHome,
}){
   return  CatyPrice(catId:catId??this.catId,price:price??this.price,priceHome:priceHome??this.priceHome);
  }
}

class CompleteRegisterCubit extends Cubit<CompleteRegisterState>{
  CompleteRegisterCubit() : super(CompleteRegisterInitState());

  static CompleteRegisterCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? user_id, sex, lat, lng, address, name, desc, token;
  List<CatyPrice?>? catIds = <CatyPrice>[];
  List? categories =[];




  Future<void> strop() async {emit(CompleteRegisterInitState());}
  Future<void> postCompleteRegister() async {
    emit(CompleteRegisterLoadingState());

    try{

      print("sex : $sex ");
      print("lat : $lat ");
      print("lng : $lng ");
      print("address : $address ");
      print("name : $name ");
      print("desc : $desc ");
      print("categories : $categories ");
      print("user ID : $user_id ");

      final url = "https://my-care.life/api/completeadvertiserdata";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      print( _pref.getInt("pro_id"));
      print(categories);
      final body = {
        "user_id" : _pref.getInt("pro_id"),
        "sex" : sex,
        "lat" : lat,
        "lng" : lng,
        "address" : address,
        "name" : name,
        "desc" : desc,
        'categories': jsonEncode({"categories": categories}),
        "google_token" : token,
      };

      FormData formData = FormData.fromMap(body);
      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(CompleteRegisterSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(CompleteRegisterErrorState(response.data["msg"]));
        print("يا عممممممممممممممممممم");
      }

    }catch(e){
      emit(CompleteRegisterErrorState(e.toString()));
      CompleteRegisterInitState();
    }
  }
}

