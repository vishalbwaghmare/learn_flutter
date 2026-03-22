
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyderated_bloc/hyderated_bloc/theme/theme_bloc.dart';
import 'counter/bloc/counter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${context.watch<CounterBloc>().state.counter}',
          style: const TextStyle(
            fontSize: 64,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            child: Icon(Icons.brightness_1),
          )
        ],
      ),
    );
  }
}
