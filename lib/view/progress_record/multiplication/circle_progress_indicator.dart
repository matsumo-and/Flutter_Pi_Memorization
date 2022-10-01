import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../model/multiplication/calculation_mode.dart';
import '../../../model/multiplication/course.dart';
import '../../../model/multiplication/multiplication_archivement.dart';

class MultiplicationCircularProgress extends ConsumerStatefulWidget {
  const MultiplicationCircularProgress({Key? key}) : super(key: key);

  @override
  MultiplicationCircularProgressState createState() =>
      MultiplicationCircularProgressState();
}

class MultiplicationCircularProgressState
    extends ConsumerState<MultiplicationCircularProgress> {
  static const double lineWidth = 12;

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
    //進捗バーは画面横サイズの半分-Paddingにする
    final double size = MediaQuery.of(context).size.width / 2 - 30;

    //全10問 * モード数 *　コース数　(演習＋本番)が進捗における最大の場合の数
    final int maxProgressCount =
        10 * CalculationMode.values.length * (Course.exercise().length + 1);

    //現在の最大正回数をすべて足し合わせて全体の場合の数で割った値　＝＝　percent
    final List<Multiplication> archiveState = ref.watch(multiplicationProvider);
    final int maxAnswers = archiveState
        .map((calc) =>
            calc.maxPracticeAnswer +
            calc.maxBeginnerAnswer +
            calc.maxProfessionalAnswer)
        .fold(0, (previousValue, currentValue) => previousValue + currentValue);
    final double percent = maxAnswers / maxProgressCount;

    return CircularPercentIndicator(
      //半径　＝　　直径/2 から太さを引いたもの　にするとちょうどSized Boxに収まる
      radius: (size / 2) - lineWidth,
      lineWidth: lineWidth,
      percent: percent,
      center: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '達成状況',
          style: Theme.of(context).textTheme.caption,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(percent * 100).floor()}',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontSize: 32),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '%',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ]),
      backgroundColor: const Color.fromRGBO(236, 239, 241, 1),
      linearGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(81, 133, 213, 1),
            Color.fromRGBO(103, 149, 224, 1)
          ]),
    );
  }
}
