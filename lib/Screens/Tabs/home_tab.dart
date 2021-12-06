import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          buildTrendingWidget(),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 180,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top-Rated Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                ),
                Container(
                  height: 120,
                  color: Colors.black,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Movies')
                        .where("ratings", isGreaterThan: 8.0)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 100,
                            width: 180,
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Please try again later',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return BuildMovieCard(
                              movieID: snapshot.data!.docs[index]['movieID'],
                              movieName: snapshot.data!.docs[index]['name'],
                              thumbnail: snapshot.data!.docs[index]
                                  ['thumbnail'],
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 180,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Action Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                ),
                Container(
                  height: 153,
                  color: Colors.black,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Movies')
                        .where("tags", whereIn: ['action', 'thrilling']).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 100,
                            width: 180,
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Please try again later',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data!.docs.length);
                            return GestureDetector(
                              onTap: () {
                                print(snapshot.data!.docs.length);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Container(
                                  height: 70,
                                  width: 180,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    //  color: Colors.black,
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data!.docs[index]['thumbnail'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox buildTrendingWidget() {
    return SizedBox(
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
          return SizedBox(
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
                    borderRadius: BorderRadius.circular(20.0),
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
    );
  }
}

class BuildMovieCard extends StatelessWidget {
  const BuildMovieCard(
      {Key? key,
      required this.movieID,
      required this.movieName,
      required this.thumbnail})
      : super(key: key);

  final String movieID;
  final String thumbnail;
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(movieID);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          height: 70,
          width: 150,
          margin: const EdgeInsets.symmetric(
            horizontal: 6.0,
          ),
          decoration: BoxDecoration(
            //  color: Colors.black,
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: NetworkImage(thumbnail),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
