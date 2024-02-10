import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/NewPassword/Bloc/NewPass_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassCubit extends Cubit<NewPassState> {
  NewPassCubit() : super(NewPassInitState());

  static NewPassCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? new_pass, confirm_pass;

  Future<void> postNewPass() async {
    emit(NewPassLoadingState());

    try {
      print("new Pass : $new_pass | confirm pass : $confirm_pass");

      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.get("api_token");
      final url = "https://my-care.life/api/rechangepass";
      FormData formData = FormData.fromMap({
        "new_pass": new_pass,
        "confirm_pass": confirm_pass,
      });

      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final Response response = await dio.post(url, data: formData);
print(response.data);
      if(response.statusCode == 200 && response.data["msg"] == "success"){
        emit(NewPassSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(NewPassErrorState(response.data["msg"]));
      }

    } catch (e) {
      emit(NewPassErrorState("$e"));
    }
  }
}
