import 'package:flutter/material.dart';

import 'movie_section_name.dart';

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
