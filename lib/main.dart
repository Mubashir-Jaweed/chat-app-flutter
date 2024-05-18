import 'dart:async';

import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/utils/secure_storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final secureStorage = SecureStorage();

  Future checkToken() async {
    String? token = await secureStorage.read('token');
    print(
        '${token} main.dart ........................................................................ ');
    return token;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: FutureBuilder(
        future: checkToken(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            print(
                '${snapshot.data}  login..........................................');
            return const Login();
          } else {
            print(
                '${snapshot.data}  home..........................................');
            return const Home();
          }
        },
      ),
    );
  }
}
