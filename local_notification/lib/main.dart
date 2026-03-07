import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/features/local_nofitication/presentation/bloc/local_notification_bloc.dart';
import 'package:local_notification/features/local_nofitication/presentation/send_notification.dart';
import 'features/core/app_reposotory_provider.dart';
import 'features/local_nofitication/domain/repository/notification_repository.dart'; // your repository provider file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRepositoryProvider( // 👈 wrapper for repositories
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Local notification',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: BlocProvider(
          create: (context) => LocalNotificationBloc(
            context.read<NotificationRepository>(),
          ),
          child: const SendNotificationScreen(),
        ),
      ),
    );
  }
}
