import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Profile/Edit_Profile/bloc/Edit_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileCubit extends Cubit<EditProfileState>{
  EditProfileCubit() : super(EditProfileInitState());

  static EditProfileCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? userID, name, address, lat, lng, phone, token;
  File? image;

  Future<void> editProfile() async {
    emit(EditProfileLoadingState());

    try{
      print(name);
      print(address);
      print(lng);
      print(lat);
      print(phone);
      print(userID);

      final url = "https://my-care.life/api/update";

      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "user_id" : "${_pref.getInt("user_id")}",
        if(name != null)
          "name": name,
        if (address != null)
          "address": address,
        if (lat != null)
          "lat": lat,
        if (lng != null)
          "lng": lng,
        if (phone != null)
          "phone": "966${phone}",
        if (image != null)
          "imagebase": await MultipartFile.fromFile(image!.path),
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
      print("============= << CATCH ERROR >> ============");
      emit(EditProfileErrorState("$e"));
    }

  }
}