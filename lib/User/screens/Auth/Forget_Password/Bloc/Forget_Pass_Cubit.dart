import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassCubit extends Cubit<ForgetPassState>{
  ForgetPassCubit() : super(ForgetPassInitState());

  static ForgetPassCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? email;

  Future<void> postForgetPass() async {
    emit(ForgetPassLoadingState());

    try{
      final url = "https://my-care.life/api/send-forget-password";
      FormData formData = FormData.fromMap({
        "email" : email,
      });

      final Response response = await dio.post(url, data: formData);
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        _pref.setString("email", response.data["data"]["user_phone"]);
        print("email : ${response.data["data"]["user_phone"]}");
        print(response.data);
        emit(ForgetPassSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ForgetPassErrorState(response.data["msg"]));
      }

    }catch(e){
      emit(ForgetPassErrorState("$e"));
    }
  }
}