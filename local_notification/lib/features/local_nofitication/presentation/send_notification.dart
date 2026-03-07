import 'package:flutter/material.dart';
import 'package:local_notification/features/local_nofitication/presentation/bloc/local_notification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {

  @override
  void initState() {
    super.initState();

    context.read<LocalNotificationBloc>().add(InitializeNotificationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocalNotificationBloc, LocalNotificationState>(
        listener: (context, state) {
          if (state.isNotificationSent) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notification sent"))
            );
          }
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!))
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<LocalNotificationBloc, LocalNotificationState>(
              builder: (context, state) {
                if(state.isLoading){
                  const CircularProgressIndicator();
                }
                return InkWell(
                  onTap: () {
                    context.read<LocalNotificationBloc>().add(SendNotificationEvent());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.purple,
                    ),
                    child: Center(
                      child: Text(
                        "Send Notification",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

