import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/model/ProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/Bloc/ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  ProfileModel profileModel;
  bool isLoading;

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    isLoading = true;

    try {
      final url = "https://mycare.pro/api/profile";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      FormData formData = FormData.fromMap({
        "user_id": _prefs.getInt("user_id"),
      });

      final Response response = await dio.post(url, data: formData);

      if (response.statusCode == 200 && response.data["msg"] == "success") {
        print(response.data);
        profileModel = ProfileModel.fromJson(response.data);
        isLoading = false;
        emit(ProfileSuccessState());

      } else if (response.statusCode == 200 && response.data["msg"] != "success") {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        emit(ProfileErrorState(response.data['msg']));
      }
    } catch (e) {
      if (e.response != null) {
        emit(ProfileErrorState(e));
      }
    }
  }
}
