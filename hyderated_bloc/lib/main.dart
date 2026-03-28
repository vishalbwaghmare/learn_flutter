import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyderated_bloc/hyderated_bloc/counter/bloc/counter_bloc.dart';
import 'package:hyderated_bloc/hyderated_bloc/home_screen.dart';
import 'package:hyderated_bloc/hyderated_bloc/theme/theme_bloc.dart';
import 'package:hyderated_bloc/hyderated_bloc/util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(dir.path),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> CounterBloc()),
        BlocProvider(create: (context)=> ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hyderated Bloc',
            theme: state.appTheme == AppTheme.light
              ? ThemeData.light()
              : ThemeData.dark(),

            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
