import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Login/Bloc/ProviderLoginModel.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Login/Bloc/ProviderLoginState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderLoginCubit extends Cubit<ProviderLoginState>{
  ProviderLoginCubit() : super(ProviderLoginInitState());

  static ProviderLoginCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String phone, password, token;
  ProviderLoginModel providerLoginModel = ProviderLoginModel();

  Future<void> postProviderLogin() async {
    emit(ProviderLoginLoadingState());

    try{
      print("phone : $phone | password : $password");
      final url = "https://mycare.pro/api/advertiserlogin";

      FormData formData = FormData.fromMap({
        "phone" : "966${phone}",
        "password" : password.toString(),
        "google_token" : token,
      });

      final Response response = await dio.post(url, data: formData);
      SharedPreferences _pref = await SharedPreferences.getInstance();

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        providerLoginModel = ProviderLoginModel.fromJson(response.data);
        _pref.setString("api_token", response.data["api_token"]);
        _pref.setInt("pro_id", response.data["data"]["id"]);
        _pref.setString("admin", response.data["data"]["admin"]);
        print(response.data);
        emit(ProviderLoginSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ProviderLoginErrorState(response.data["msg"]));
      }

    }catch(e){
      if(e.response != null){
        emit(ProviderLoginErrorState(e));
        print("اوعى الايرور يا عم الحج");
      }

    }
  }
}