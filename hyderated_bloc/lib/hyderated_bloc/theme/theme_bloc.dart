import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../util.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.inital()) {
    on<ToggleThemeEvent>(_toggleThemeEvent);
  }

  void _toggleThemeEvent(ToggleThemeEvent event, Emitter<ThemeState> emit){

    final appTheme = state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    emit(state.copyWith(
      appTheme: appTheme,
    ));
  }
  
  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(
      appTheme: AppTheme.values[json['appTheme']],
      );
  }
  
  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {
      'appTheme': state.appTheme.index,
    };
  }
}
