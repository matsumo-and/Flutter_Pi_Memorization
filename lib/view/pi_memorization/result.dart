import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/calculation_controller.dart';
import 'package:flutter_pi_memorization/controller/multiplication_record.dart';
import 'package:flutter_pi_memorization/controller/multiplication_store.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_store.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/view/multiplication/calculation.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/pi_memolization/pi_record.dart';
import '../../model/multiplication/calculation_state.dart';
import '../../model/multiplication/course.dart';
import '../../model/multiplication/calculation_mode.dart';
import '../../model/multiplication/multiplication_archivement.dart';
import '../../model/pi_memorization/pi_mode.dart';
import '../gradient_text_button.dart';
import 'pi_question.dart';

class PiResult extends ConsumerStatefulWidget {
  final int correctDigits;
  final PiMode mode;
  const PiResult({
    Key? key,
    required this.correctDigits,
    required this.mode,
  }) : super(key: key);

  @override
  ConsumerState<PiResult> createState() => PiResultState();
}

class PiResultState extends ConsumerState<PiResult> {
  static const maxQuestionNum = 10;

  @override
  void initState() {
    //問題の結果から、コースをクリアしたか || 最大正解数を更新するか || 挑戦回数のカウントアップ　を実施する
    storeResult();
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

  void storeResult() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //更新しないパラメータについてはNullになる
      int? practiceChallenges;
      int? realChallenges;
      int? bestRecord;

      final piChallengeState = ref.read(piArchivementProvider);

      switch (widget.mode) {
        case PiMode.excersize:
          //挑戦回数のカウントアップ
          practiceChallenges = piChallengeState.practiceChallenges + 1;
          break;
        case PiMode.act:
          //挑戦回数のカウントアップ
          realChallenges = piChallengeState.realChallenges + 1;
          break;
      }

      //ローカル及びRiverpodのステートを更新する
      final piChallengeStateNotifier = ref.read(piArchivementProvider.notifier);
      piChallengeStateNotifier.set(
        practiceChallenges: practiceChallenges,
        realChallenges: realChallenges,
      );

      //Record用の総挑戦回数も更新する
      ref.read(piRecordProvider.notifier).increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(calculationProvider);
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      // appBar: AppBar(title: Text(Course.find(widget.id).title)),
      body: Stack(
        alignment: Alignment.bottomCenter,
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
                      children: questionState
                                  .where((element) => element.isCorrect == true)
                                  .length ==
                              maxQuestionNum
                          ? [
                              SizedBox(
                                height: 200,
                                width: 200,
                                // child: widget.mode.medal
                              ),
                              const Text('合格おめでとうございます！！\nこの調子で頑張りましょう！'),
                            ]
                          : [
                              const SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image(
                                      image: AssetImage(
                                    'assets/result.multiplication.png',
                                  ))),
                              const Text('お疲れ様でした！\nこの調子で頑張りましょう！'),
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
                                  '${questionState.where((element) => element.isCorrect == true).toList().length} / $maxQuestionNum問')
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
                            Ink(
                              color: state.isCorrect
                                  ? Colors.transparent
                                  : const Color.fromRGBO(255, 235, 238, 1),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 40,
                                    child: Icon(
                                      state.isCorrect
                                          ? Icons.circle_outlined
                                          : Icons.close_outlined,
                                      color: state.isCorrect
                                          ? const Color.fromRGBO(
                                              81, 133, 213, 1)
                                          : const Color.fromRGBO(
                                              224, 70, 45, 1),
                                      size: 24,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5,
                                              color: Color.fromRGBO(
                                                  33, 33, 33, 0.2))),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '(${state.index}) ${state.multiplier} × ${state.multiplicand} = ${state.multiplier * state.multiplicand}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        Text(
                                          '${state.secElapsed}秒',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    )),

                //最後までスクロールするためにSafeAreaとStackボタン分の高さを確保する
                SizedBox(height: MediaQuery.of(context).padding.bottom + 80),
              ],
            ),
          ),

          //リトライボタン
          Container(
            //セーフサイズを避けて描画する
            padding: const EdgeInsets.all(16).add(
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)),
            color: Colors.white,
            child: GradientTextButton(
              height: 45,
              width: MediaQuery.of(context).size.width,
              title: 'リトライ',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => PiQuestion(
                          mode: widget.mode,
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
