import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/firebase_config.dart';
import 'core/services/notification_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
  );
  print("Handling a background message: ${message.messageId}");
  // You can add your custom logic here to handle the background message.
}

Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final firebaseOptions = FirebaseConfig.createOptions();

  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize application services (Dependency injection)
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