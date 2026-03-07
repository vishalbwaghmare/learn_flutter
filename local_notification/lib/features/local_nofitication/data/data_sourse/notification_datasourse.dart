import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationDataSource {

  Future<void> initializeNotification() async{
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notification',
            channelDescription: 'Notification channel for test',
            defaultColor: Colors.deepPurple,
            ledColor: Colors.white
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group'
        )
      ],
      debug: true,
    );
  }

  Future<void> sendNotification() async{
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if(!isAllowed) isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();
    if(!isAllowed) return;

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Hello Notification',
          body: 'This is my first notification',
        )
    );
  }
}