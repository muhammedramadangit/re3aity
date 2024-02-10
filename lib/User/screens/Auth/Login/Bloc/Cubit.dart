import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Login/Bloc/state.dart';
import 'package:re3aity/social_login/social_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
   String? phone;
   String? token;
   String? password;
   String? apiToken;

  Future<void> login() async {
    emit(LoginLoadingState());

    try {
      print(phone);
      print(password);

      final url = "https://my-care.life/api/userlogin";
      FormData formData = FormData.fromMap({
        "phone" : "966${phone}",
        "password" : password,
        "google_token": token,
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString("api_token", response.data["api_token"]);
        _prefs.setString("admin", response.data["data"]["admin"]);
        _prefs.setInt("user_id", response.data["data"]["id"]);
        apiToken = _prefs.getString("api_token");
        print(response.data);
        emit(LoginSuccessState());
      } else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(LoginErrorState(response.data['msg']));
      }
    } catch (e) {
      emit(LoginErrorState("$e"));
    }
  }


  Future<void> loginWithGoogle(SocialModel model) async {
    emit(LoginLoadingGoogleState());

    try {
      final url = "https://my-care.life/api/social_login";
      print(model.login().entries);

      FormData formData = FormData.fromMap(model.login());
      final Response response = await dio.post(url, data: formData);

      log("RESPONSE ${response.data}");
      if(response.statusCode == 200 && response.data["msg"] == "success"){
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString("api_token", response.data["api_token"]);
        _prefs.setString("admin", response.data["data"]["admin"]);
        _prefs.setInt("user_id", response.data["data"]["id"]);
        apiToken = _prefs.getString("api_token");
        print(response.data);
        emit(LoginSuccessState());
      } else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(LoginErrorState(response.data['data']));
      }
    } catch (e) {
      emit(LoginErrorState("$e"));
    }
  }
}
