import 'package:flutter/material.dart';

class MovieTypeContainerHeading extends StatelessWidget {
  const MovieTypeContainerHeading({
    Key? key,
    this.title,
    this.fontSize = 18,
  }) : super(key: key);

  final String? title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
        fontSize: fontSize,
      ),
    );
  }
}
