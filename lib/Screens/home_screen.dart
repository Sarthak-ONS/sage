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
      "name": "The Haunted",
      "movieID": "",
      "actors": [
        "Vicky Kaushal",
        "Selena Gomez",
        "Jhanvi Kapoor",
      ],
      "description":
          "Films — Kaushal rose to prominence in 2018 with supporting roles in Raazi and Sanju, two of the highest-grossing Hindi films of the year. For the latter, he ..Films — Kaushal rose to prominence in 2018 with supporting roles in Raazi and Sanju, two of the highest-grossing Hindi films of the year. For the latter, he ..",
      "duration": 169,
      "ratings": 9.8,
      "tags": [
        "horror",
        "adventureous",
        "Comedy",
      ],
      "link": "www.google.com",
      "thumbnail":
          "https://images.pexels.com/photos/10399171/pexels-photo-10399171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "yearOfRelease": "2021"
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
          backgroundColor: const Color(0xffC43030),
          label: const Text('Search'),
          icon: const Icon(Icons.search),
        ),
        backgroundColor: const Color(0xff0A0A0A),
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
              backgroundColor: Colors.black,
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
