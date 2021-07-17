import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/SignUp/Bloc/State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderSignUpCubit extends Cubit<ProviderSignUpState>{
  ProviderSignUpCubit() : super(ProviderSignUpInitState());

  static ProviderSignUpCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String phone, password, confirmpass, token;

  Future<void> ProviderSignUp() async {
    emit(ProviderSignUpLoadingState());

    try{
      print("phone : $phone | password : $password | confirm Password : $confirmpass");
      final url = "https://mycare.pro/api/advertiserRegister";
      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
        "password" : password,
        "confirmpass" : confirmpass,
        "google_token" : token,
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString("api_token", response.data["api_token"]);
        _pref.setInt("pro_id", response.data["data"]["id"]);
        _pref.setString("admin", response.data["data"]["admin"]);
        print(response.data["data"]["id"]);
        print(response.data);
        emit(ProviderSignUpSuccessState());

      } else if (response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ProviderSignUpErrorState(response.data["msg"]),);
        print("اوعى الايرور يا عم الحاج");
      }

    }catch (e) {
      if (e.response != null){
        emit(ProviderSignUpErrorState(e));
        print("اعاااااااااا");
      }
    }
  }
}