import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sage/Widgets/movie_card.dart';
import 'package:sage/Widgets/section_heading_button.dart';
import 'package:sage/private_variable.dart';
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
      backgroundColor: const Color(0xff0F171E),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          //Trending MOvies
          buildTrendingWidget(),
          const SizedBox(
            height: 10.0,
          ),
          //Continaer For Top-Rated Movies
          Container(
            height: 160,
            color: const Color(0xff0F171E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeadingButton(
                    title: "Top-Rated Movies", callBack: () {}),
                Container(
                  height: 120,
                  color: const Color(0xff0F171E),
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
                              color: const Color(0xff0F171E),
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
          //Container For Watch in your Language
          Container(
            height: 180,
            color: const Color(0xff0F171E),
            child: Column(
              children: [
                SectionHeadingButton(
                    title: "Watch in Your Language", callBack: () {}),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 135,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      height: 120,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            listOfImages[index],
                            scale: 0.5,
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    itemCount: 6,
                  ),
                ),
              ],
            ),
          ),
          // Container For Action Movies
          Container(
            height: 160,
            color: const Color(0xff0F171E),
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
                  color: const Color(0xff0F171E),
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
                              color: const Color(0xff0F171E),
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
          //Container For Horror Movies
          Container(
            height: 160,
            color: const Color(0xff0F171E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeadingButton(
                  title: "Horror Movies",
                  callBack: () {},
                ),
                Container(
                  height: 120,
                  color: const Color(0xff0F171E),
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
                              color: const Color(0xff0F171E),
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
                  color: const Color(0xff00A8E1),
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
