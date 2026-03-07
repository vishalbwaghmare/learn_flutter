import 'package:local_notification/features/local_nofitication/data/data_sourse/notification_datasourse.dart';
import 'package:local_notification/features/local_nofitication/demain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository{

  final NotificationDataSource dataSource;

  const NotificationRepositoryImpl(this.dataSource);

  @override
  Future<void> initializeNotification() async{
    await dataSource.initializeNotification();
  }

  @override
  Future<void> sendNotification() async{
    await dataSource.sendNotification();
  }
}