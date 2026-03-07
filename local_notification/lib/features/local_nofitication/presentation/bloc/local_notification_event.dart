part of 'local_notification_bloc.dart';

sealed class LocalNotificationEvent extends Equatable {
  const LocalNotificationEvent();
}

final class InitializeNotificationEvent extends LocalNotificationEvent{
  @override
  List<Object?> get props => [];
}

final class SendNotificationEvent extends LocalNotificationEvent{
  @override
  List<Object?> get props => [];
}
