import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationServices {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final ValueNotifier<bool> hasNewNotification = ValueNotifier(false);

  RemoteMessage? latestMessage;
  bool _appJustLaunched = true;

  initFCM()async{

    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    //print("FCM token : $fcmToken");

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print("Message : ${message.notification?.title}");
      latestMessage = message; //save message
      hasNewNotification.value = true;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print("Message : ${message.notification?.title}");
      if(!_appJustLaunched){
        latestMessage = message;
        hasNewNotification.value = true;
      }
    });
    _appJustLaunched = false;
  }

  void clearNotificationState(){
    hasNewNotification.value = false;
  }
}