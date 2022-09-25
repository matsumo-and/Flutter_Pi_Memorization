import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MultiplicationCircularProgress extends ConsumerStatefulWidget {
  const MultiplicationCircularProgress({Key? key}) : super(key: key);

  @override
  MultiplicationCircularProgressState createState() =>
      MultiplicationCircularProgressState();
}

class MultiplicationCircularProgressState
    extends ConsumerState<MultiplicationCircularProgress> {
  final double percent = 0.75;

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
    return SizedBox(
      width: 200,
      height: 200,
      child: CircularPercentIndicator(
        radius: 75,
        lineWidth: 15,
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
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ]),
        linearGradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(81, 133, 213, 1),
              Color.fromRGBO(103, 149, 224, 1)
            ]),
      ),
    );
  }
}
