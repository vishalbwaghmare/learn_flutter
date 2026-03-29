import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hyderated_bloc/core/secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hint: Text("Enter input"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  )
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 2,
                  shadowColor: Colors.purple.shade500,
                  fixedSize: Size(200, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                onPressed: (){
                  SecureStorageService().setValue("test", _controller.text);
                }, 
                child: Text("Save Info")
                ),
                const SizedBox(height: 18,),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 2,
                  shadowColor: Colors.purple.shade500,
                  fixedSize: Size(200, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                onPressed: ()async{
                  final result = await SecureStorageService().getValue("test");
                  log(result ?? "");

                }, 
                child: Text("Get Info")
                ),
                const SizedBox(height: 18,),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 2,
                  shadowColor: Colors.purple.shade500,
                  fixedSize: Size(200, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                onPressed: ()async{
                 final result = await SecureStorageService().getAllValue();
                 log(result.toString());
                }, 
                child: Text("Get all Info")
                ),
                const SizedBox(height: 18.0,),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 2,
                  shadowColor: Colors.purple.shade500,
                  fixedSize: Size(200, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                onPressed: ()async{
                  await SecureStorageService().deleteValue("test");
                  final result = await SecureStorageService().getValue("test");
                  log(result ?? "");
                }, 
                child: Text("Delete Info")
                ),
                const SizedBox(height: 18.0,),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 2,
                  shadowColor: Colors.purple.shade500,
                  fixedSize: Size(200, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                onPressed: ()async{
                  await SecureStorageService().deleteAll();
                  final result = await SecureStorageService().getValue("test");
                  log(result ?? "");
                }, 
                child: Text("Delete all Info")
                ),
            ],
          ),
        ),
      ),
    );
  }
}