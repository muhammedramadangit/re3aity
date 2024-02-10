import 'package:re3aity/Provider/Screens/MyReservation/model/model.dart';
import 'package:re3aity/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationController {
  NetworkUtil _util = NetworkUtil();
 // ReversationsModel _reversationsModel =ReversationsModel();
 //
 //  Future<ReversationsModel> getReservation() async {
 //    SharedPreferences _pref = await SharedPreferences.getInstance();
 //    Map<String, dynamic> header = {
 //      "Accept": "application/json",
 //      "Content-Type": "application/json",
 //      "Authorization": "Bearer ${_pref.get("api_token")}",
 //    };
 //
 //    final data = await _util.get("ownerreservation", headers: header);
 //    if (data == null) {
 //      _reversationsModel = null;
 //      return _reversationsModel;
 //    } else {
 //      _reversationsModel = ReversationsModel.fromJson(data.data);
 //      print(data.data);
 //      return _reversationsModel;
 //    }
 //  }
}
