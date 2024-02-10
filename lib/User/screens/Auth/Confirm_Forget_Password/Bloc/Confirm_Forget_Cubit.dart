import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Confirm_Forget_Password/Bloc/Confirm_Forget_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmForgetCubit extends Cubit<ConfirmForgetState>{
  ConfirmForgetCubit() : super(ConfirmForgetInitState());

  static ConfirmForgetCubit get(context) => BlocProvider.of(context);

  Dio dio = Dio();
  String? code;

  Future<void> postConfirmForget() async {
    emit(ConfirmForgetLoadingState());

    try{
      print("code : $code");
      final url = "https://my-care.life/api/verify-forget-password";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final email = _pref.getString("email");

      dio.options.headers = {
        "Accept" : "application/json",
      };

      FormData formData = FormData.fromMap({
        "email" : email,
        "code" : code,
      });

      final Response response = await dio.post(url, data: formData);
      log("RESPONSE ${response.data}");
      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(ConfirmForgetSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ConfirmForgetErrorState(response.data["msg"]));
      }

    }catch(e){
      emit(ConfirmForgetErrorState("$e"));
    }
  }
}