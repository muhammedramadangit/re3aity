import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Confim_Code/bloc/confirmCodeState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeState> {
  ConfirmCodeCubit() : super(ConfirmCodeInitState());

  static ConfirmCodeCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? code;

  Future<void> VerifyCode() async {
    emit(ConfirmCodeLoadingState());

    try {
      print("code : $code");
      final url = "https://my-care.life/api/phone-verify";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("api_token");

      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      FormData body = FormData.fromMap({
        "code": code,
      });
print("TOKEN $token");
      final Response response = await dio.post(url, data: body);
      log("RESPONSE ${response.data}");
      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(ConfirmCodeSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ConfirmCodeErrorState(response.data["msg"]));
      }

    } catch (e) {
      emit(ConfirmCodeErrorState("$e"));
    }
  }
}
