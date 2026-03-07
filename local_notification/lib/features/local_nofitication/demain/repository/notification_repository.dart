abstract class NotificationRepository {
  Future<void> initializeNotification();
  Future<void> sendNotification();
}