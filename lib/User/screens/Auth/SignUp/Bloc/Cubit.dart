import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Auth/SignUp/Bloc/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String name, phone, sex, password, confirmpass, code, token;

  Future<void> SignUp() async {
    emit(SignUpLoadingState());

    try {
      print("name : $name | phone : $phone | sex : $sex  | password : $password | confirm password : $confirmpass ");
      final url = "https://mycare.pro/api/addRegister";
      FormData formData = FormData.fromMap({
        "name" : name,
        "phone" : "966${phone}",
        "sex" : "ذكر",
        "lat" : "122.2",
        "lng" : "122.2",
        "address" : "address",
        "password" : password.toString(),
        "confirmpass" : confirmpass.toString(),
        "google_token" : token,
      });

      final Response response = await dio.post(url, data: formData);
      if(response.statusCode == 200 && response.data["msg"] == "success"){
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString("api_token", response.data["api_token"]);
        _prefs.setInt("user_id", response.data["data"]["id"]);
        code = response.data["sms_code"];
        print(response.data);
        emit(SignUpSuccessState());
      } else if(response.statusCode == 200 && response.data["msg"] != "success"){
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        emit(SignUpErrorState(response.data['msg']));
      }
    } catch (e) {
      if(e.response != null){
        emit(SignUpErrorState(e));
      }
    }
  }
}
