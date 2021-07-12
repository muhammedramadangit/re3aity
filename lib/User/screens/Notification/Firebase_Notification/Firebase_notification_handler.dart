import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FireBaseNotifications {
  FirebaseMessaging _fireBaseMessaging = FirebaseMessaging();

  Future<String> setUpFireBase(context) async{
    String token;
    _fireBaseMessaging = FirebaseMessaging();
    token = await fireBaseCloudMessagingListeners(context);
    return token;
  }

  Future<String> fireBaseCloudMessagingListeners(context) {
    if (Platform.isIOS) iOSPermission();

    _fireBaseMessaging.getToken().then((token) {
      print('FCM__Notification__Token');
      print(token);
    });

    _fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
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
                message['notification'] != null
                    ? message['notification']['title']
                    : message['aps']['alert']['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                message['notification'] != null
                      ? message['notification']['body']
                      : message['aps']['alert']['body'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "حسنا",
                  style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    return _fireBaseMessaging.getToken();
  }

  void iOSPermission() {
    _fireBaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _fireBaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
