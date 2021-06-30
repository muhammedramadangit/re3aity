import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Bloc/ProviderProfileState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState>{
  ProviderProfileCubit() : super(ProviderProfileInitState());

  static ProviderProfileCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String user_id, name, phone, address, image;

  Future<void> postProviderProfile() async {
    emit(ProviderProfileLoadingState());

    try{
      print("user ID : $user_id");

      final url = "https://mycare.pro/api/profile";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("pro_token");
      FormData formData = FormData.fromMap({
        "user_id" : user_id,
      });

      dio.options.headers = {
        "Accept" : "application/json",
        "Authorization" : "Bearer ${token}",
      };

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        name = response.data["data"]["name"];
        phone = response.data["data"]["phone"];
        address = response.data["data"]["address"];
        image = response.data["data"]["image"];
        print(response.data["data"]["id"]);
        print(response.data);
        emit(ProviderProfileSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        print("====== ERROR =======");
        emit(ProviderProfileErrorState(response.data["msg"]));
      }

    }catch (e){
      if(e.response != null){
        print("======== CATCH ERROR =========");
        emit(ProviderProfileErrorState(e));
      }

    }
  }
}