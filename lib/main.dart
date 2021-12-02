import 'package:flutter/material.dart';
import 'package:sage/Screens/home_screen.dart';
import 'package:sage/Screens/login_screen.dart';
import 'package:sage/Services/google_sign_in_Api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
