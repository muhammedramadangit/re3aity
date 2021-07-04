import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassCubit extends Cubit<ForgetPassState>{
  ForgetPassCubit() : super(ForgetPassInitState());

  static ForgetPassCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String phone;

  Future<void> postForgetPass() async {
    emit(ForgetPassLoadingState());

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
        emit(ForgetPassSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ForgetPassErrorState(response.data["msg"]));
      }

    }catch(e){
      if(e.response != null){
        emit(ForgetPassErrorState(e));
      }
    }
  }
}