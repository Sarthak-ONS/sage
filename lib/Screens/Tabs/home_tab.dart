import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          Container(
            height: 200,
            child: FutureBuilder<Object>(
              future: FirebaseFirestore.instance.collection('Trending').get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                return Container(
                  child: CarouselSlider.builder(
                    itemCount: snapshot.data!.docs.length,
                    options: CarouselOptions(
                        autoPlay: true,
                        // aspectRatio: 2.0,
                        enlargeCenterPage: false,
                        viewportFraction: 1),
                    itemBuilder: (context, index, realIdx) {
                      return Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(snapshot.data!.docs.length.toString()),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              snapshot.data!.docs[index]['thumbnail'],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
