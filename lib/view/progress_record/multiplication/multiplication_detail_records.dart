import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication/multiplication_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/multiplication/multiplication_store.dart';
import '../../../model/multiplication/calculation_mode.dart';
import '../../../model/multiplication/course.dart';
import '../../../model/multiplication/multiplication_archivement.dart';
import 'circle_progress_indicator.dart';

class MultiplicationDetailRecords extends StatelessWidget {
  const MultiplicationDetailRecords({Key? key}) : super(key: key);

  static final ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));
  static const Color _cardColor = Color.fromRGBO(250, 250, 250, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const MultiplicationCircularProgress(),

                    //Padding
                    const SizedBox(height: 15),

                    Consumer(
                      builder: ((context, ref, _) {
                        final multiplicationRecodeState =
                            ref.watch(multiplicationRecodeProvider);

                        final int totalChallenges =
                            multiplicationRecodeState.fold(
                                0,
                                (preValue, record) =>
                                    preValue + record.totalChallenges);

                        final int totalDates = multiplicationRecodeState.length;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //総挑戦回数
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$totalChallenges 回',
                                    style:
                                        Theme.of(context).textTheme.headline2),
                                Text('総挑戦回数',
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),

                            //総学習日数
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$totalDates 日',
                                    style:
                                        Theme.of(context).textTheme.headline2),
                                Text('総学習日数',
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                )),
            const SizedBox(height: 15),
            for (int index = 0; index < Course.exercise().length; index++)
              detailCourseCard(
                  context: context, id: Course.exercise()[index].id),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom)),
          ],
        ),
      ),
    );
  }

  ///コースごと・モードごとにクリアしたかの実績を表示するカード
  Widget detailCourseCard({required BuildContext context, required int id}) {
    const double height = 120;
    final double width = MediaQuery.of(context).size.width;
    const double iconSize = 50;
    const EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 12, vertical: 7);

    return Consumer(builder: (context, ref, _) {
      final Multiplication multiplication = ref
          .watch(multiplicationProvider)
          .firstWhere((element) => element.id == id,
              orElse: () => const Multiplication());
      return Card(
        color: Colors.white,
        shape: _cardShape,
        margin: padding,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(15),
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Course.find(id).title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                //初心者コース
                Expanded(
                  child: Card(
                    color: _cardColor,
                    shape: _cardShape,
                    elevation: 0,
                    child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              height: iconSize,
                              width: iconSize,
                              child: multiplication.beginnerDone
                                  ? CalculationMode.beginner.medal
                                  : CalculationMode.none.medal,
                            ),
                            Text(
                              '初心者コース',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontSize: 14,
                                    color: multiplication.beginnerDone
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                            ),
                          ],
                        )),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),

                //達人コース
                Expanded(
                  child: Card(
                    color: _cardColor,
                    shape: _cardShape,
                    elevation: 0,
                    child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              height: iconSize,
                              width: iconSize,
                              child: multiplication.professionalDone
                                  ? CalculationMode.professional.medal
                                  : CalculationMode.none.medal,
                            ),
                            Text(
                              '達人コース',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontSize: 14,
                                    color: multiplication.professionalDone
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                            ),
                          ],
                        )),
                  ),
                ),
              ]),
            ],
          ),
        ),
      );
    });
  }
}
