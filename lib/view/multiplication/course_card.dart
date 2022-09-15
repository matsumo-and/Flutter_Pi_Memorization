import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication_store.dart';
import 'package:flutter_pi_memorization/model/exercise_course.dart';
import 'package:flutter_pi_memorization/model/multiplication_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/medal.dart';

class CourseCard extends StatelessWidget {
  final double height;
  final Function onTap;
  final int id;

  const CourseCard(
      {Key? key, required this.onTap, required this.id, this.height = 80})
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
              Consumer(builder: (context, ref, _) {
                final multiplicationState =
                    ref.read(multiplicationProvider.notifier);
                final Multiplication multiplication =
                    multiplicationState.find(id);
                return Container(
                  padding: medalPadding,
                  height: height,
                  width: height,
                  child: multiplication.professionalDone
                      ? Medal.professional.icon
                      : multiplication.beginnerDone
                          ? Medal.beginner.icon
                          : Medal.none.icon,
                );
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ExcersiseCourse.find(id).title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    ExcersiseCourse.find(id).caption,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
