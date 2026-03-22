//import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends HydratedBloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementCounterEvent>(_incrementCounterEvent);
    on<DecrementCounterEvent>(_decrementCounterEvent);
    on<ResetCounter>(_resetCounter);
  }

  void _incrementCounterEvent(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _decrementCounterEvent(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }

  Future<void> _resetCounter(ResetCounter event, Emitter<CounterState> emit) async{
    await clear(); 
    emit(state.copyWith(counter: 0));
  }

  //RESTORE State
  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState(counter: json['counter'] ?? 0);
  }

  //SAVE State
  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return {'counter': state.counter};
  }
}
