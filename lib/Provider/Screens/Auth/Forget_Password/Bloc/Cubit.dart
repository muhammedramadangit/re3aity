import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Forget_Password/Bloc/State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderForgetCubit extends Cubit<ProviderForgetStat>{
  ProviderForgetCubit() : super(ProviderForgetInitState());

  static ProviderForgetCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String phone;

  Future<void> postProviderForget() async {
    emit(ProviderForgetLoadingState());

    try{
      print("phone : $phone");

      final url = "https://mycare.pro/api/send-forget-password";
      FormData formData = FormData.fromMap({
        "phone" : "966$phone"
      });

      final Response response = await dio.post(url, data: formData);
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        _pref.setString("phone", response.data["data"]["user_phone"]);
        print("phone : ${response.data["data"]["user_phone"]}");
        print(response.data);
        emit(ProviderForgetSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ProviderForgetErrorState(response.data["msg"]));
      }

    }catch(e){
      if(e.response != null){
        emit(ProviderForgetErrorState(e));
      }
    }
  }
}