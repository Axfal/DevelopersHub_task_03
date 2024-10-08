import 'package:firebase/main.dart';
import 'package:firebase/ui/notification_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    if (kDebugMode) {
      print('fCMToken = $fCMToken');
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    nevigatorKey.currentState
        ?.pushNamed('NotificationPage', arguments: message);
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
