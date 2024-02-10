import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Edit_Profile/Bloc/Edit_State.dart';


class EditProviderCubit extends Cubit<EditProviderState>{
  EditProviderCubit() : super(EditProviderInitState());

  static EditProviderCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? userID, name, address, lat, lng, phone;
  File? image;

  Future<void> editProvider() async {
    emit(EditProviderLoadingState());

    try{
      print(name);
      print(address);
      print(lng);
      print(lat);
      print(phone);
      print(userID);
      print(image!.path);

      final url = "https://my-care.life/api/update";

      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "user_id" : _pref.getInt("pro_id"),
        "name" : name,
        "address" : address,
        "lat" : lat,
        "lng" : lng,
        "phone" : "966${phone}",
        "imagebase" : await MultipartFile.fromFile(image!.path),
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(EditProviderSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        print("============= << STATE ERROR >> ============");
        emit(EditProviderErrorState(response.data["msg"]));
      }

    }catch (e){
      emit(EditProviderErrorState("$e"));
    }

  }
}