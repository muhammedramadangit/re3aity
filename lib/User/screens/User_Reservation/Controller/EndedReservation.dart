import 'package:lastre3ayty/User/screens/User_Reservation/Model/EndedReservation.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndedController {
  NetworkUtil _util = NetworkUtil();
  EndedModel _endedModel = EndedModel();

  Future<EndedModel> getEnded() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_pref.get("api_token")}",
    };

    final data = await _util.get("finishedreservation", headers: header);
    if (data == null) {
      _endedModel = null;
      return _endedModel;
    } else {
      _endedModel = EndedModel.fromJson(data.data);
      return _endedModel;
    }
  }
}
