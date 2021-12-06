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

  setMovieDoc() {
    FirebaseFirestore.instance.collection('Movies').add({
      "name": "Insidious",
      "movieID": "",
      "actors": [
        "Vicky Kaushal",
        "Selena Gomez",
        "Jhanvi Kapoor",
      ],
      "description":
          "Action film is a film genre in which the protagonist or protagonists are thrust into a series of events that typically include violence, extended fighting, physical feats, rescues and frantic chases. Action film is a film genre in which the protagonist or protagonists are thrust into a series of events that typically include violence, extended fighting, physical feats, rescues and frantic chases.",
      "duration": 169,
      "ratings": 8.7,
      "tags": [
        "horror",
        "adventureous",
        "Comedy",
        "action",
      ],
      "link": "www.google.com",
      "thumbnail":
          "https://images.pexels.com/photos/3062541/pexels-photo-3062541.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "yearOfRelease": "2020"
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //TODO: Add Search Feature
            setMovieDoc();
            print(
              Provider.of<GoogleAuthpProvider>(context, listen: false).name,
            );
          },
          backgroundColor: const Color(0xff19232E),
          label: const Text('Search'),
          icon: const Icon(Icons.search),
        ),
        backgroundColor: const Color(0xff19232E),
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
                    height: 30,
                    width: 30,
                    scale: 0.5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'S',
                    style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
                  ),
                  const Text(
                    'age',
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  ),
                ],
              ),
              backgroundColor: const Color(0xff19232E),
              // pinned: true,
              snap: true,
              floating: true,
              pinned: true,
              expandedHeight: 130.0,
              actions: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      foregroundImage: NetworkImage(
                        Provider.of<GoogleAuthpProvider>(context).photoUrl!,
                      ),
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                indicatorColor: const Color(0xffC43030),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
                isScrollable: false,
                physics: const BouncingScrollPhysics(),
                tabs: const [
                  Tab(
                    text: 'Home',
                  ),
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
