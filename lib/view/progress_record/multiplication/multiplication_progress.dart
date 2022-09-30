import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication_record.dart';
import 'package:flutter_pi_memorization/view/progress_record/multiplication/multiplication_detail_records.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/multiplication_store.dart';
import '../../../model/multiplication/calculation_mode.dart';
import '../../../model/multiplication/course.dart';
import '../../../model/multiplication/multiplication_archivement.dart';
import 'circle_progress_indicator.dart';

class MultiplicationProgress extends StatelessWidget {
  const MultiplicationProgress({Key? key}) : super(key: key);

  static const double _padding = 12;
  static final ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));
  static const Color _cardColor = Color.fromRGBO(250, 250, 250, 1);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            shape: _cardShape,
            margin: const EdgeInsets.all(_padding),
            child: Padding(
              padding: const EdgeInsets.all(_padding),
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
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const MultiplicationDetailRecords())));
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const MultiplicationCircularProgress(),
                      Column(
                        children: List.generate(
                            Course.exercise().length > 3
                                ? 3
                                : Course.exercise().length,
                            (index) => progressCourseCard(
                                  context: context,
                                  id: Course.exercise()[index].id,
                                )),
                      ),
                    ],
                  ),

                  //下線付きPadding
                  Container(
                    height: 15,
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(33, 33, 33, 0.2))),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        //総挑戦階数
                        Expanded(
                          child: Card(
                            elevation: 0,
                            shape: _cardShape,
                            color: _cardColor,
                            child: Container(
                                height: 80,
                                padding: const EdgeInsets.all(_padding),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Icon(
                                            Icons.check_circle_outline,
                                            size: 16,
                                          ),
                                        ),
                                        Text(
                                          '総挑戦回数',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Consumer(builder: (context, ref, _) {
                                          final int totalChallenges = ref
                                              .watch(
                                                  multiplicationRecodeProvider)
                                              .fold(
                                                  0,
                                                  (preValue, record) =>
                                                      preValue +
                                                      record.totalChallenges);
                                          return Text(
                                            '$totalChallenges',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(fontSize: 24),
                                          );
                                        }),
                                        Text(
                                          '回',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),

                        //総学習回数
                        Expanded(
                          child: Card(
                            elevation: 0,
                            shape: _cardShape,
                            color: _cardColor,
                            child: Container(
                                height: 80,
                                padding: const EdgeInsets.all(_padding),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Icon(
                                            Icons.calendar_month,
                                            size: 16,
                                          ),
                                        ),
                                        Text(
                                          '総学習日数',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Consumer(builder: (context, ref, _) {
                                          final totalDates = ref
                                              .watch(
                                                  multiplicationRecodeProvider)
                                              .length;
                                          return Text(
                                            '$totalDates',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(fontSize: 24),
                                          );
                                        }),
                                        Text(
                                          '日',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget progressCourseCard({required BuildContext context, required int id}) {
    //画面サイズの半分から両側のPaddingを引いた値
    const double height = 55;
    final double width = MediaQuery.of(context).size.width / 2 - (_padding * 2);
    const double iconSize = 50;
    return Card(
      color: _cardColor,
      shape: _cardShape,
      elevation: 0,
      child: SizedBox(
        height: height,
        width: width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(builder: (context, ref, _) {
                final Multiplication multiplication = ref
                    .watch(multiplicationProvider)
                    .firstWhere((element) => element.id == id,
                        orElse: () => const Multiplication());
                return SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: multiplication.professionalDone
                      ? CalculationMode.professional.medal
                      : multiplication.beginnerDone
                          ? CalculationMode.beginner.medal
                          : CalculationMode.none.medal,
                );
              }),
              SizedBox(
                width: width - iconSize,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Course.find(id).title,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Course.find(id).caption,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
