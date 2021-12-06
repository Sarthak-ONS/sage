import 'package:flutter/material.dart';

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
