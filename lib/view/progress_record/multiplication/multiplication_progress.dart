import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'package:flutter_pi_memorization/view/multiplication/multiplication_home.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';

import '../../../model/multiplication/course.dart';
import '../../../model/multiplication/multiplication_archivement.dart';
import '../../multiplication/course_card.dart';
import 'circle_progress_indicator.dart';

class MultiplicationProgress extends StatefulWidget {
  const MultiplicationProgress({Key? key}) : super(key: key);

  @override
  State<MultiplicationProgress> createState() => MultiplicationProgressState();
}

class MultiplicationProgressState extends State<MultiplicationProgress> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TappableCard(
            height: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(12),
            onTap: null,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(33, 33, 33, 0.2))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '実績',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        TextButton(
                          onPressed: () {
                            ///TODO Naviagete to List of archivement
                          },
                          child: const Text(
                            'すべて見る',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 122, 255, 1)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: MultiplicationCircularProgress(),
                      ),

                      ///TODO implement smaller CourseCard
                      // Column(
                      //   children: List.generate(
                      //       Course.exercise().length > 3
                      //           ? 3
                      //           : Course.exercise().length,
                      //       (index) => ConstrainedBox(
                      //             constraints: BoxConstraints(
                      //                 maxWidth:
                      //                     MediaQuery.of(context).size.width /
                      //                         2),
                      //             child: CourseCard(
                      //               id: Course.exercise()[index].id,
                      //             ),
                      //           )),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
