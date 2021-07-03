import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Auth/Login/Bloc/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
   String phone;
   String token;
   String password;

  Future<void> login() async {
    emit(LoginLoadingState());

    try {
      print(phone);
      print(password);

      final url = "https://mycare.pro/api/userlogin";
      FormData formData = FormData.fromMap({
        "phone" : "966${phone}",
        "password" : password,
        "google_token":token,
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString("api_token", response.data["api_token"]);
        print(response.data);
        emit(LoginSuccessState());
      } else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(LoginErrorState(response.data['msg']));
      }
    } catch (e) {
      if(e.response != null){
        emit(LoginErrorState(e));
      }
    }
  }
}
