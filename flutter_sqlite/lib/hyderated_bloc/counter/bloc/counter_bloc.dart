import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementCounterEvent>(_incrementCounterEvent);
    on<DecrementCounterEvent>(_decrementCounterEvent);
  }

  void _incrementCounterEvent(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(
      counter: state.counter +1
    ));
  }

  void _decrementCounterEvent(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(
      counter: state.counter - 1
    ));
  }
}
