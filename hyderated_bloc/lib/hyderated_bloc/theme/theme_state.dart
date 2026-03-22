part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final AppTheme appTheme;
  const ThemeState({required this.appTheme});

  factory ThemeState.inital(){
    return ThemeState(appTheme: AppTheme.light);
  }

  ThemeState copyWith({
    AppTheme? appTheme,
  }){
    return ThemeState(
        appTheme: appTheme ?? this.appTheme
    );
  }

  @override
  List<Object> get props => [appTheme];
}
