import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/calculation_controller.dart';
import 'package:flutter_pi_memorization/controller/numeric_keyboard_controller.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_pi_memorization/view/multiplication/progress_bar.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/multiplication/calculation_state.dart';
import '../../model/multiplication/course.dart';
import '../../model/multiplication/medal.dart';
import '../gradient_text_button.dart';

class ResultPage extends ConsumerStatefulWidget {
  final int id;
  final CalculationMode mode;
  const ResultPage({Key? key, required this.id, required this.mode})
      : super(key: key);

  @override
  ResultPageState createState() => ResultPageState();
}

class ResultPageState extends ConsumerState<ResultPage> {
  static const maxQuestionNum = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(calculationProvider);
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(Course.find(widget.id).title)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: widget.mode.medal,
                        ),
                        const Text('合格おめでとうございます！！\nこの調子で頑張りましょう！'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                TappableCard(
                    height: 160,
                    margin: const EdgeInsets.all(8),
                    onTap: null,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '結果発表',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                size: 24,
                                color: Color.fromRGBO(81, 133, 213, 1),
                              ),
                              Text(
                                '正解数',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const Spacer(),
                              Text(
                                  '${questionState.where((element) => element.isCorrect == true).toList().length} / 10問')
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                size: 24,
                                color: Color.fromRGBO(81, 133, 213, 1),
                              ),
                              Text(
                                'タイマー',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const Spacer(),
                              Text(
                                '${timerState.secElapsed} 秒',
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),

                const SizedBox(height: 10),

                TappableCard(
                    height: 70 * (questionState.length.toDouble() + 1),
                    margin: const EdgeInsets.all(8),
                    onTap: null,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '詳細',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),

                          //ユーザーが解いた問題についての採点リスト
                          for (CalculationState state in questionState)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 40,
                                  child: Icon(
                                    state.isCorrect
                                        ? Icons.circle_outlined
                                        : Icons.close_outlined,
                                    color: state.isCorrect
                                        ? const Color.fromRGBO(81, 133, 213, 1)
                                        : const Color.fromRGBO(224, 70, 45, 1),
                                    size: 24,
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide.none),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '(${state.index}) ${state.multiplier} × ${state.multiplicand} = ${state.multiplier * state.multiplicand}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      Text(
                                        '${state.secElapsed}秒',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    )),

                //最後までスクロールするためにSafeAreaとStackボタン分の高さを確保する
                SizedBox(height: MediaQuery.of(context).padding.bottom + 80),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: GradientTextButton(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  title: 'リトライ',
                  onPressed: () {
                    print("object");
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ],
      ),
    );
  }
}
