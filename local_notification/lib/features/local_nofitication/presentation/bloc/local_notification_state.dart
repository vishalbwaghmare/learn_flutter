part of 'local_notification_bloc.dart';

class LocalNotificationState extends Equatable {
  final bool isNotificationSent;
  final bool isLoading;
  final String? error;

  const LocalNotificationState({
    required this.isNotificationSent,
    required this.isLoading,
    this.error,
  });

  factory LocalNotificationState.initial() {
    return const LocalNotificationState(
      isNotificationSent: false,
      isLoading: false,
      error: null,
    );
  }

  LocalNotificationState copyWith({
    bool? isNotificationSent,
    bool? isLoading,
    String? error,
    bool resetError = false,
  }) {
    return LocalNotificationState(
      isNotificationSent: isNotificationSent ?? this.isNotificationSent,
      isLoading: isLoading ?? this.isLoading,
      error: resetError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [isNotificationSent, isLoading, error];
}

