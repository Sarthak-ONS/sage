import 'package:flutter/material.dart';
import 'package:sage/Services/google_sign_in_Api.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final user = await GoogleSignInApi().login();
            if (user == null) {
              print("User has Cancelled Sign in Process");
            } else {
              // Navigator.push(
              //   context,

              // );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          },
          child: const Text('Google Sign in '),
        ),
      ),
    );
  }
}
