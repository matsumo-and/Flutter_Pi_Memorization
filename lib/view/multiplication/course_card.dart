import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/medal.dart';

class CourseCard extends StatelessWidget {
  final double height;
  final Medal medal;
  final String title;
  final String caption;
  final Function onTap;

  const CourseCard(
      {Key? key,
      this.medal = Medal.none,
      required this.title,
      required this.caption,
      required this.onTap,
      this.height = 80})
      : super(key: key);

  //card shape
  static const EdgeInsets cardMargin =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);
  static final RoundedRectangleBorder border =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));

  //card background color
  static const Color backgroundColor = Colors.white;

  //medal location
  static const EdgeInsets medalPadding = EdgeInsets.symmetric(horizontal: 10);

  //title style
  static const TextStyle style = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Card(
          margin: cardMargin,
          color: backgroundColor,
          shape: border,
          child: SizedBox(
            height: height,
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Container(
                padding: medalPadding,
                height: height,
                width: height,
                child: medal.icon,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    caption,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
