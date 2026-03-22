import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../util.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.inital()) {
    on<ToggleThemeEvent>(_toggleThemeEvent);
  }

  void _toggleThemeEvent(ToggleThemeEvent event, Emitter<ThemeState> emit){

    final appTheme = state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    emit(state.copyWith(
      appTheme: appTheme,
    ));
  }
}
