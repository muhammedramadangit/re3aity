import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/NewPassword/bloc/ProviderNewPassState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderNewPassCubit extends Cubit<ProviderNewPassState>{
  ProviderNewPassCubit() : super(ProviderNewPassInitState());

  static ProviderNewPassCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String new_pass, confirm_pass;

  Future<void> providerNewPass() async {
    emit(ProviderNewPassLoadingState());

    try {
      print("new Pass : $new_pass | confirm pass : $confirm_pass");

      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.get("api_token");
      final url = "https://mycare.pro/api/rechangepass";
      FormData formData = FormData.fromMap({
        "new_pass": new_pass,
        "confirm_pass": confirm_pass,
      });

      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        emit(ProviderNewPassSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        print("<<<<<<<< STATE ERROR!! >>>>>>>");
        emit(ProviderNewPassErrorState(response.data["msg"]));
      }

    } catch (e) {
      if(e.response != null){
        print("<<<<<<<< CATCH ERROR!! >>>>>>>");
        emit(ProviderNewPassErrorState(e));
      }
    }
  }
}