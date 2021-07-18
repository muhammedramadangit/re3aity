import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Profile/Edit_Profile/bloc/Edit_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileCubit extends Cubit<EditProfileState>{
  EditProfileCubit() : super(EditProfileInitState());

  static EditProfileCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String userID, name, address, lat, lng, phone, token;
  File image;

  Future<void> editProfile() async {
    emit(EditProfileLoadingState());

    try{
      print(name);
      print(address);
      print(lng);
      print(lat);
      print(phone);
      print(userID);

      final url = "https://mycare.pro/api/update";

      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "user_id" : "${_pref.getInt("user_id")}",
        "name" : name,
        "address" : address,
        "lat" : lat,
        "lng" : lng,
        "phone" : "966${phone}",
        "imagebase" : await MultipartFile.fromFile(image.path),
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        token = _pref.getString("api_token");
        print(response.data);
        emit(EditProfileSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        print("============= << STATE ERROR >> ============");
        emit(EditProfileErrorState(response.data["msg"]));
      }

    }catch (e){
      if(e.response != null){
        print("============= << CATCH ERROR >> ============");
        emit(EditProfileErrorState(e));
      }
    }

  }
}