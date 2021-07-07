import 'package:dio/dio.dart';
import 'package:lastre3ayty/Provider/Screens/Notification/Model/ProviderNotifiModel.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderNotificationController {
  NetworkUtil _util = NetworkUtil();
  ProviderNotificationModel _notificationModel = ProviderNotificationModel();

  Future<ProviderNotificationModel> getProNotification() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    final Map<String, String> header = {
      "Accept" : "application/json",
      "Content-Type" : "application/json",
      "Authorization" : "Bearer ${_pref.getString("api_token")}",
    };

    final Response response = await _util.get("ownernotification", headers: header);

    if(response.data == null){
      _notificationModel = null;
      return _notificationModel;
    }else{
      _notificationModel = ProviderNotificationModel.fromJson(response.data);
      return _notificationModel;
    }
  }
}