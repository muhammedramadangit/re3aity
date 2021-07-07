import 'package:dio/dio.dart';
import 'package:lastre3ayty/User/screens/Notification/model/notification_model.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController {
  NetworkUtil _util = NetworkUtil();
  NotificationModel _notificationModel = NotificationModel();

  Future<NotificationModel> getNotification() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    final Map<String, String> header = {
      "Accept" : "application/json",
      "Content-Type" : "application/json",
      "Authorization" : "Bearer ${_pref.getString("api_token")}",
    };

    final Response response = await _util.get("usernotification", headers: header);

    if(response.data == null){
      _notificationModel = null;
      return _notificationModel;
    }else{
      _notificationModel = NotificationModel.fromJson(response.data);
      return _notificationModel;
    }
  }
}