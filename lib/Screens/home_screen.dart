import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sage/Providers/google_auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Image.asset(
            "Assets/logo.png",
            scale: 0.5,
          ),
          title: const Text(
            'Sage',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CircleAvatar(
            //     radius: 20,
            //     foregroundImage: NetworkImage(
            //       Provider.of<GoogleAuthpProvider>(context).user.photoUrl!,
            //     ),
            //   ),
            // )
          ],
        ),
        endDrawer: Drawer(
          elevation: 20,
        ),
        body: Column(
          children: [
            const Center(
              child: Text('Home Page'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<GoogleAuthpProvider>(context, listen: false)
                    .logout();
              },
              child: const Text(
                'Logout',
              ),
            )
          ],
        ),
      ),
    );
  }
}
