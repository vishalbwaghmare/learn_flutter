import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/notification_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final NotificationServices notificationServices;
  const HomeScreen({super.key, required this.notificationServices});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _showNotification(RemoteMessage message){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(message.notification?.title ?? "Notification"),
            content: Text(message.notification?.body ?? ""),
            actions: [
              TextButton(
                  onPressed: ()=> Navigator.of(context).pop(),
                  child: const Text("Close")
              )
            ],
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push notification", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          ValueListenableBuilder<bool>(
              valueListenable: widget.notificationServices.hasNewNotification,
              builder: (context, hasNew, child){
                return IconButton(
                    onPressed: (){
                      final message = widget.notificationServices.latestMessage;

                      if(message != null){
                        _showNotification(message);
                      }
                      widget.notificationServices.clearNotificationState();
                    },
                    icon: Stack(
                      children: [
                        Icon(Icons.notifications, color: Colors.white,),
                        if(hasNew)
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minHeight: 12,
                                  maxWidth: 12,
                                ),
                              )
                          )
                      ],
                    )
                );
              }
          )
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to Push Notification App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

