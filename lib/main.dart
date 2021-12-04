import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sage/Providers/google_auth_provider.dart';
import 'package:sage/Providers/user_details.dart';
import 'package:sage/Services/firebase_firestore_api.dart';

import 'Screens/home_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => UserData(),
        ),
        Provider(
          create: (context) => GoogleAuthpProvider(),
        ),
        Provider(
          create: (context) => FirebaseFireStoreProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, fontFamily: 'PoppinsRegular'),
        home: const HomePageLoginWidget(),
      ),
    );
  }
}
