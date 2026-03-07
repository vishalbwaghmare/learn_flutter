import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/features/local_nofitication/data/repositories/notification_repository_impl.dart';
import '../local_nofitication/data/data_sourse/notification_datasourse.dart';
import '../local_nofitication/domain/repository/notification_repository.dart';

class App{
  static List<RepositoryProvider> repositoryProvider = [
    RepositoryProvider<NotificationRepository>(
        create: (context)=> NotificationRepositoryImpl(context.read<NotificationDataSource>())
    )
  ];
}