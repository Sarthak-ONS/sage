import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sage/Providers/google_auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //TODO: Add Search Feature
            print(
              Provider.of<GoogleAuthpProvider>(context, listen: false).name,
            );
          },
          backgroundColor: Colors.red,
          label: const Text('Search'),
          icon: const Icon(Icons.search),
        ),
        backgroundColor: Colors.black,
        appBar: buildAppBar(context),
        endDrawer: const Drawer(
          elevation: 20,
        ),
        body: ListView(
          children: const [],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            "Assets/logo.png",
            height: 40,
            width: 40,
            scale: 0.5,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Sage',
            style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: Colors.black,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            foregroundImage: NetworkImage(
              Provider.of<GoogleAuthpProvider>(context).photoUrl!,
            ),
          ),
        )
      ],
    );
  }
}
// Column(
//           children: [
//             const Center(
//               child: Text('Home Page'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Provider.of<GoogleAuthpProvider>(context, listen: false)
//                     .logout();
//               },
//               child: const Text(
//                 'Logout',
//               ),
//             )
//           ],
//         )
