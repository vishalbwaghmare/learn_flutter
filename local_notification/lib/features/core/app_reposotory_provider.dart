import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/features/local_nofitication/data/data_sourse/notification_datasourse.dart';
import 'package:local_notification/features/local_nofitication/data/repositories/notification_repository_impl.dart';

import '../local_nofitication/domain/repository/notification_repository.dart';

class AppRepositoryProvider extends StatelessWidget {
  final Widget child;

  const AppRepositoryProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => NotificationDataSource(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepositoryImpl(
            context.read<NotificationDataSource>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
