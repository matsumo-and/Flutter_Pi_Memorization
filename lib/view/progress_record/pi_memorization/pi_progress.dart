import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_challenges.dart';
import 'package:flutter_pi_memorization/view/progress_record/calendar.dart';
import 'package:flutter_pi_memorization/view/progress_record/pi_memorization/charts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PiProgress extends StatelessWidget {
  const PiProgress({Key? key}) : super(key: key);

  static const EdgeInsets _padding = EdgeInsets.all(12);
  static final ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));
  static const Color _cardColor = Color.fromRGBO(250, 250, 250, 1);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 0,
            shape: _cardShape,
            margin: _padding,
            child: Padding(
              padding: _padding,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(33, 33, 33, 0.2))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '実績',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  const PiChart(),

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
                        //総挑戦回数
                        Expanded(
                          child: Card(
                            elevation: 0,
                            shape: _cardShape,
                            color: _cardColor,
                            child: Container(
                                height: 80,
                                padding: _padding,
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
                                              .watch(piChallengesRecordProvider)
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
                                padding: _padding,
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
                                              .watch(piChallengesRecordProvider)
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
          ),

          //pdding
          const SizedBox(height: 15),

          //Calendar
          const ProgressCalendar(
            calendarType: CalendarType.piMemorization,
          ),
        ],
      ),
    );
  }
}
