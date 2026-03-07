import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:local_notification/features/local_nofitication/demain/repository/notification_repository.dart';

part 'local_notification_event.dart';
part 'local_notification_state.dart';

class LocalNotificationBloc extends Bloc<LocalNotificationEvent, LocalNotificationState> {
  final NotificationRepository _repository;
  
  LocalNotificationBloc(this._repository) : super(LocalNotificationState.initial()) {
    on<InitializeNotificationEvent>(_initializeNotification);
    on<SendNotificationEvent>(_sendNotificationEvent);
  }

  Future<void> _initializeNotification(InitializeNotificationEvent event, Emitter<LocalNotificationState> emit) async {
    await _repository.initializeNotification();
  }

  Future<void> _sendNotificationEvent(SendNotificationEvent event, Emitter<LocalNotificationState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      error: null,
      isNotificationSent: false,
    ));

    try {
      await _repository.sendNotification();

      emit(state.copyWith(
        isLoading: false,
        isNotificationSent: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        error: error.toString(),
      ));
    }
  }
}
