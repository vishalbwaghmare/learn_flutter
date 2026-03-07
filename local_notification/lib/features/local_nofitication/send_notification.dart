import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {

  Future<void> _initializeNotification() async{
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
    if(!isAllowed) isAllowed = await displayNotificationRational();
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

  static Future<bool> displayNotificationRational()async{
    bool isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();

    return isAllowed;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 3), ()async{
      await _initializeNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: (){
              sendNotification();
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.purple,
              ),
              child: Center(
                child: Text(
                  "Send Notification",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

