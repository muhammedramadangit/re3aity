import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FireBaseNotifications {
  Future<String?> setUpFireBase(context) async{
    String? token;
    token = await fireBaseCloudMessagingListeners(context);
    return token;
  }

  Future<String?> fireBaseCloudMessagingListeners(context) async {
    // if (Platform.isIOS) iOSPermission();
    _initNotification();
    String? deviceToken = await FirebaseMessaging.instance.getToken().then((token) {
      print('FCM__Notification__Token');
      print(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      print('on message $message');
      Future.delayed(Duration(seconds: 2));
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: ListTile(
            title: Text(
              message.data['notification'] != null
                  ? message.data['notification']['title']
                  : message.data['aps']['alert']['title'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
              message.data['notification'] != null
                  ? message.data['notification']['body']
                  : message.data['aps']['alert']['body'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Text(
                "حسنا",
                style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onLaunch: $message");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onResume: $message");
    });

    return deviceToken;
  }
}

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
AndroidInitializationSettings? _initializationSettingsAndroid;
DarwinInitializationSettings? _initializationSettingsIos;
InitializationSettings? _initializationSettings;

Future _initNotification() async {
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  _initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher'); /// < - - ICON..
  _initializationSettingsIos = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: false,
  );
  _initializationSettings = InitializationSettings(android: _initializationSettingsAndroid, iOS: _initializationSettingsIos);
  await _flutterLocalNotificationsPlugin.initialize(_initializationSettings!);
}
