import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Confim_Code/Bloc/VerifyState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderVerifyCubit extends Cubit<ProviderVerifyState> {
  ProviderVerifyCubit() : super(ProviderVerifyInitState());

  static ProviderVerifyCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String code;

  Future<void> postProviderVerifyCode() async {
    emit(ProviderVerifyLoadingState());

    try {
      print("code : $code");
      final url = "https://mycare.pro/api/phone-verify";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("api_token");

      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      FormData body = FormData.fromMap({
        "code": code,
      });

      final Response response = await dio.post(url, data: body);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(ProviderVerifySuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ProviderVerifyErrorState(response.data["msg"]));
      }

    } catch (e) {
      if(e.response != null){
        emit(ProviderVerifyErrorState(e));
      }
    }
  }
}

