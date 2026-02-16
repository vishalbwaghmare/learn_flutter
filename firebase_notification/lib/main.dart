import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/firebase_options.dart';
import 'package:firebase_notification/home_screen.dart';
import 'package:firebase_notification/notification_services.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, like Firestore,
  // make sure you call `initializeApp` before using them.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
  // You can add your custom logic here to handle the background message.
}

Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final notificationService = NotificationServices();
  await notificationService.initFCM();
  runApp(MyApp(notificationService: notificationService,));
}

class MyApp extends StatelessWidget {
  final NotificationServices notificationService;
  const MyApp({super.key, required this.notificationService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Push Notification Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent)),
      home: HomeScreen(notificationServices: notificationService),
    );
  }
}