import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication_store.dart';
import 'package:flutter_pi_memorization/model/multiplication/course.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/multiplication/medal.dart';
import '../../model/multiplication/multiplication_archivement.dart';
import 'mode_select.dart';

class CourseCard extends StatelessWidget {
  final int id;

  const CourseCard({Key? key, required this.id}) : super(key: key);

  //card shape
  static const double height = 80;
  static const EdgeInsets cardMargin =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);
  static final RoundedRectangleBorder border =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));

  //medal location
  static const EdgeInsets medalPadding = EdgeInsets.symmetric(horizontal: 10);

  //title style
  static const TextStyle style = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return TappableCard(
      border: border,
      margin: cardMargin,
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) => ModeSelect(id: id)));
      },
      child: Row(children: [
        Consumer(builder: (context, ref, _) {
          final Multiplication multiplication = ref
              .watch(multiplicationProvider)
              .firstWhere((element) => element.id == id,
                  orElse: () => const Multiplication());
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
              Course.find(id).title,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              Course.find(id).caption,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        )
      ]),
    );
  }
}
