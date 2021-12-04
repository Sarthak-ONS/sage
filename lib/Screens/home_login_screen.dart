import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sage/Providers/google_auth_provider.dart';
import 'package:sage/Screens/login_screen.dart';
import 'package:sage/Services/firebase_firestore_api.dart';

import 'home_screen.dart';

class HomePageLoginWidget extends StatelessWidget {
  const HomePageLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            Provider.of<GoogleAuthpProvider>(context, listen: false)
                .changeCurrentUserDetails(
              name: FirebaseAuth.instance.currentUser!.displayName,
              email: FirebaseAuth.instance.currentUser!.email,
              uid: FirebaseAuth.instance.currentUser!.uid,
              photoUrl: FirebaseAuth.instance.currentUser!.photoURL,
            );
            Provider.of<FirebaseFireStoreProvider>(context, listen: false)
                .createProfile(
              Provider.of<GoogleAuthpProvider>(context, listen: false).uid!,
              Provider.of<GoogleAuthpProvider>(context, listen: false).name!,
              Provider.of<GoogleAuthpProvider>(context, listen: false).email!,
              Provider.of<GoogleAuthpProvider>(context, listen: false)
                  .photoUrl!,
            );
            //
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return const LoginScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
