import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Bloc/Profile_State.dart';
import 'package:re3aity/Provider/Screens/Provider_Profile/Profile/Model/Provider_Profile_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  ProviderProfileCubit() : super(ProviderProfileInitState());

  static ProviderProfileCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  ProviderProfileModel? providerProfileModel;
  bool? isLoading;

  Future<void> providerProfile() async {
    emit(ProviderProfileLoadingState());
    isLoading = true;

    try {
      final url = "https://my-care.life/api/profile";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      FormData formData = FormData.fromMap({
        "user_id": _prefs.getInt("pro_id"),
      });

      final Response response = await dio.post(url, data: formData);

      if (response.statusCode == 200 && response.data["msg"] == "success") {
        print(response.data);
        providerProfileModel = ProviderProfileModel.fromJson(response.data);
        isLoading = false;
        emit(ProviderProfileSuccessState());

      } else if (response.statusCode == 200 && response.data["msg"] != "success") {
        print("errrrrrrrror");
        emit(ProviderProfileErrorState(response.data['msg']));
      }
    } catch (e) {
      emit(ProviderProfileErrorState("$e"));
    }
  }
}
