import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/Provider/Screens/Auth/SignUp/Bloc/State.dart';
import 'package:re3aity/social_login/social_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderSignUpCubit extends Cubit<ProviderSignUpState>{
  ProviderSignUpCubit() : super(ProviderSignUpInitState());

  static ProviderSignUpCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? phone, password, confirmpass, token, email;

  Future<void> ProviderSignUp() async {
    emit(ProviderSignUpLoadingState());

    try{
      print("phone : $phone | password : $password | confirm Password : $confirmpass");
      final url = "https://my-care.life/api/advertiserRegister";
      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
        "email" : email,
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
      }

    }catch (e) {
      emit(ProviderSignUpErrorState(e.toString()));
    }
  }


  Future<void> ProviderSocialSignUp(SocialModel model) async {
    emit(ProviderSocialSignUpLoadingState());

    try{
      final url = "https://my-care.life/api/complete_social_login_advertiser";
      FormData formData = FormData.fromMap(model.register());

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
      }

    }catch (e) {
      emit(ProviderSignUpErrorState(e.toString()));
    }
  }
}