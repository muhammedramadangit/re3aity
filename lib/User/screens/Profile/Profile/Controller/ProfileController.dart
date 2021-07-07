import 'package:dio/dio.dart';
import 'package:lastre3ayty/User/screens/Profile/Profile/model/ProfileModel.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileController {
  NetworkUtil _util = NetworkUtil();
  ProfileModel _profileModel = ProfileModel();

  Future<ProfileModel> postProfile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
    };

    FormData formData = FormData.fromMap({
      "user_id" : "${_pref.getInt("user_id")}"
    });

    final Response response = await _util.post("profile", headers: header, body: formData);

    if (response.data == null ) {
      _profileModel = null;
      return _profileModel;
    } else {
      _profileModel = ProfileModel.fromJson(response.data);
      return _profileModel;
    }
  }
}

//
// void PostData() async {
//   print("In service");
//   NetworkUtil _util = NetworkUtil();
//   SharedPreferences _pref = await SharedPreferences.getInstance();
//
//   Map<String, dynamic> header = {
//       "Accept": "application/json",
//     };
//
//     FormData formData = FormData.fromMap({
//       "user_id" : "${_pref.getInt("user_id")}"
//     });
//   Response response = await _util.post("login?lang=ar", body: formData, headers: header);
//
//   print(response.statusCode);
//   if (response.data["status"] == true) {
//     print("In service");
//     print("Done");
//
//   } else {
//     print("ERROR");
//     print("In service");
//
//   }
// }