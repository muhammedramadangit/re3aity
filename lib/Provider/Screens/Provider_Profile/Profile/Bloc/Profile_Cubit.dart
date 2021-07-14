import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_State.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Profile/Model/Provider_Profile_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  ProviderProfileCubit() : super(ProviderProfileInitState());

  static ProviderProfileCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  ProviderProfileModel providerProfileModel = ProviderProfileModel();

  Future<void> providerProfile() async {
    emit(ProviderProfileLoadingState());

    try {
      final url = "https://mycare.pro/api/profile";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      FormData formData = FormData.fromMap({
        "user_id": _prefs.getInt("pro_id"),
      });

      final Response response = await dio.post(url, data: formData);

      if (response.statusCode == 200 && response.data["msg"] == "success") {
        print(response.data);
        providerProfileModel = ProviderProfileModel.fromJson(response.data);
        emit(ProviderProfileSuccessState());

      } else if (response.statusCode == 200 && response.data["msg"] != "success") {
        print("errrrrrrrror");
        emit(ProviderProfileErrorState(response.data['msg']));
      }
    } catch (e) {
      if (e.response != null) {
        emit(ProviderProfileErrorState(e));
      }
    }
  }
}
