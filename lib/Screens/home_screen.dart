import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sage/Providers/google_auth_provider.dart';
import 'package:sage/Screens/Tabs/home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    controller = TabController(
      length: 3,
      vsync: this,
    );
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
          backgroundColor: const Color(0xffC43030),
          label: const Text('Search'),
          icon: const Icon(Icons.search),
        ),
        backgroundColor: Colors.black,
        // appBar: buildAppBar(context),
        endDrawer: const Drawer(
          elevation: 20,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  Image.asset(
                    "Assets/logo.png",
                    height: 40,
                    width: 40,
                    scale: 0.5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Sage',
                    style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                  ),
                ],
              ),
              backgroundColor: Colors.black,
              // pinned: true,
              snap: true,
              floating: true,
              pinned: true,
              expandedHeight: 130.0,
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
              bottom: TabBar(
                indicatorColor: Colors.red,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Home'),
                  Tab(text: 'TV Shows'),
                  Tab(text: 'Movies'),
                ],
                controller: controller,
              ),
            ),
            // SliverList(
            SliverFillRemaining(
              child: TabBarView(
                controller: controller,
                children: const [
                  HomeTab(),
                  Center(child: Text("Tab two")),
                  Center(child: Text("Tab three")),
                ],
              ),
            )
          ],
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
          const SizedBox(
            width: 10,
          ),
          const Text(
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
