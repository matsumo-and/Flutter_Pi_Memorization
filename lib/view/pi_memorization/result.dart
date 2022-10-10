import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_best_record.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_store.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/pi_memolization/pi_challenges.dart';
import '../../controller/pi_memolization/pickerController.dart';
import '../../model/pi_memorization/pi.dart';
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
  @override
  void initState() {
    //挑戦回数を増やし、必要であれば最大正解数を更新する
    storeResult();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void storeResult() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //タイマーを停止する
      ref.read(timerProvider.notifier).stop();

      //更新しないパラメータについてはNullになる
      int? practiceChallenges;
      int? realChallenges;

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
      ref.read(piChallengesRecordProvider.notifier).increment();

      //BestRecordListの最後の要素が一番値が大きいことが確約されている
      final piBestRecordsListState = ref.read(piBestRecordsListProvider);
      final int bestRecordByNow = piBestRecordsListState.isEmpty
          ? 0
          : piBestRecordsListState.last.bestRecord ?? 0;

      //円周率が過去最高記録であれば更新する
      if (widget.correctDigits > bestRecordByNow) {
        ref
            .read(piBestRecordsListProvider.notifier)
            .update(bestRecord: widget.correctDigits);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final pickerState = ref.watch(pickerProvider);
    final appBarSubTitle = widget.mode == PiMode.excersize
        ? ' (${pickerState.digitsFrom} ~ ${pickerState.digitsTo})'
        : '';
    final goalDigits = widget.mode == PiMode.act
        ? Pi.fullDigits.length
        : pickerState.digitsTo - pickerState.digitsFrom + 1;

    return Scaffold(
      appBar: AppBar(title: Text('${widget.mode.appBarTitle}$appBarSubTitle')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      children: widget.correctDigits == goalDigits
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
                                '回答数',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const Spacer(),
                              Text('${widget.correctDigits} / $goalDigits 桁')
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
