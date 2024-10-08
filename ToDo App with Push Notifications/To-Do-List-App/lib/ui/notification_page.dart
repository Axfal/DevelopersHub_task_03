// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class NotificationPage extends StatelessWidget {
  static const String id = 'NotificationPage';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
      ),
      body: Column(
        children: [
          Center(child: Text(message.notification!.title.toString())),
          Center(child: Text(message.notification!.body.toString())),
          Center(child: Text(message.data.toString())),
        ],
      ),
    );
  }
}
