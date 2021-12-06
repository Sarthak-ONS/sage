import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sage/Widgets/movie_card.dart';
import 'package:sage/Widgets/movie_section_name.dart';
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
      backgroundColor: const Color(0xff0A0A0A),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          buildTrendingWidget(),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 160,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeadingButton(
                    title: "Top-Rated Movies", callBack: () {}),
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
            height: 160,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeadingButton(
                    title: "Action Movies",
                    callBack: () {
                      print("Heading Towars Section Heading Action Movies");
                    }),
                Container(
                  height: 120,
                  color: Colors.black,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Movies')
                        .limit(15)
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
                        print(snapshot.error.toString() + "////////");
                        return const Center(
                          child: Text(
                            'Please try again later',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        print(snapshot.data!.docs.length);

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data!.docs.length);
                            List tags = snapshot.data!.docs[index]['tags'];
                            if (tags.contains("action") == false) {
                              return Container();
                            }
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
            height: 160,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeadingButton(
                  title: "Horror Movies",
                  callBack: () {},
                ),
                Container(
                  height: 120,
                  color: Colors.black,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Movies')
                        .limit(15)
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
                        print(snapshot.error.toString() + "////////");
                        return const Center(
                          child: Text(
                            'Please try again later',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        print(snapshot.data!.docs.length);

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data!.docs.length);
                            List tags = snapshot.data!.docs[index]['tags'];
                            if (tags.contains("horror") == false) {
                              return Container();
                            }
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
                return Banner(
                  message: '#${index + 1}',
                  location: BannerLocation.topEnd,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Text(snapshot.data!.docs.length.toString()),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          snapshot.data!.docs[index]['thumbnail'],
                        ),
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

class SectionHeadingButton extends StatelessWidget {
  const SectionHeadingButton(
      {Key? key, required this.title, required this.callBack})
      : super(key: key);

  final String? title;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MovieTypeContainerHeading(
            title: title,
          ),
          Row(
            children: const [
              Text(
                'View All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
