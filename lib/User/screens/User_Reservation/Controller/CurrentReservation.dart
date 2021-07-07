import 'package:lastre3ayty/User/screens/User_Reservation/Model/CurrentReservation.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentController {
  NetworkUtil _util = NetworkUtil();
  CurrentModel _currentModel = CurrentModel();

  Future<CurrentModel> getCurrent() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_pref.get("api_token")}",
    };

    final data = await _util.get("initreservation", headers: header);
    if (data == null) {
      _currentModel = null;
      return _currentModel;
    } else {
      _currentModel = CurrentModel.fromJson(data.data);
      return _currentModel;
    }
  }
}
