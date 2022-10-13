import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication/calculation_controller.dart';
import 'package:flutter_pi_memorization/controller/numeric_keyboard_controller.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_pi_memorization/view/multiplication/progress_bar.dart';
import 'package:flutter_pi_memorization/view/multiplication/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/multiplication/calculation_state.dart';
import '../../model/multiplication/calculation_mode.dart';
import '../gradient_text_button.dart';

class CalculationPage extends ConsumerStatefulWidget {
  final int id;
  final CalculationMode mode;
  const CalculationPage({Key? key, required this.id, required this.mode})
      : super(key: key);

  @override
  CalculationPageState createState() => CalculationPageState();
}

class CalculationPageState extends ConsumerState<CalculationPage> {
  static const maxQuestionNum = 10;
  static const int maxCount = 3;

  //各問題にかかった秒数を計測する(DateTimeではなく秒数)
  int lastSubmitted = 0;

  //カウントインの回数を保持する
  int count = 0;

  @override
  void initState() {
    //ここで初めてInitializeしてStateの中身を決めるためビルド中には行えないらしい。ビルド後にInitializeする
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //引数のIDを受け取ってランダムな掛け算問題を生成する.
      ref
          .read(calculationProvider.notifier)
          .initialize(id: widget.id, mode: widget.mode);

      //以前のキーボードの状態をクリアする
      ref.read(keyboardProvider.notifier).clear();

      //カウントインを表示してから（awaitしてから）タイマーをスタートする
      await showCountIn();

      ref.read(timerProvider.notifier).start(
          mode: widget.mode,
          onTimerEnd: () {
            //timerが終了したらリザルト画面に遷移する。
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    MultiplicationResult(id: widget.id, mode: widget.mode)));
          });
    });

    super.initState();
  }

  @override
  void deactivate() {
    //Pageが破棄されると同時にタイマーを停止する。
    ref.read(timerProvider.notifier).stop();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> showCountIn() async {
    //練習モードであればカウントインは表示しない
    if (widget.mode == CalculationMode.none) return;

    //1秒ごとカウントアップし、カウントがcountInSecを上回ったら
    for (int sec = 0; sec < maxCount + 1; sec++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        count++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardState = ref.watch(keyboardProvider);
    final keyboardStateNotifier = ref.read(keyboardProvider.notifier);

    //ビルド後にInitializeするため State.last は例外を吐く可能性がある（実行時エラー）
    final questionState = ref.watch(calculationProvider);
    final currentQuestion =
        questionState.isEmpty ? const CalculationState() : questionState.last;

    return widget.mode != CalculationMode.none && count <= maxCount
        ? countIn(count)
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Text('${currentQuestion.index}/$maxQuestionNum問目')),
            body: Stack(
              children: [
                //タイマーのプログレスバー。練習モード以外なら表示する
                Visibility(
                  visible: widget.mode != CalculationMode.none,
                  child: const ProgressBar(),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${currentQuestion.multiplier} × ${currentQuestion.multiplicand}',
                      style: const TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            '=',
                            style: TextStyle(
                                fontSize: 40,
                                color: Color.fromRGBO(77, 77, 77, 0.4)),
                          ),
                        ),

                        const Padding(padding: EdgeInsets.all(8)),

                        //カーソルやシステムキーボードは表示させないテキストフィールド
                        Container(
                          height: 45,
                          width: 145,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5,
                                color: const Color.fromRGBO(77, 77, 77, 0.4)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            keyboardState.toString(),
                            style: const TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        //TextFormFieldの位置を真ん中に合わせるための暫定対応
                        const Padding(padding: EdgeInsets.all(8)),
                        const Text('=',
                            style: TextStyle(
                                fontSize: 40, color: Colors.transparent)),
                      ],
                    ),
                    const SizedBox(height: 10),

                    //Submit Button
                    GradientTextButton(
                      title: '回答する',
                      height: 45,
                      width: 145,
                      onPressed: keyboardState.isEmpty
                          ? null
                          : () {
                              //SUBMIT して次の問題を表示する
                              ref.watch(calculationProvider.notifier).submit(
                                  userAnswer: int.tryParse(keyboardState)!,
                                  secElapsed:
                                      ref.read(timerProvider).secElapsed -
                                          lastSubmitted,
                                  onComplete: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiplicationResult(
                                                    id: widget.id,
                                                    mode: widget.mode)));
                                  });

                              //回答した時間を保持、次回差分を出す
                              lastSubmitted =
                                  ref.read(timerProvider).secElapsed;

                              //テキスト内容を初期化する
                              keyboardStateNotifier.clear();
                            },
                      disabled: keyboardState.isEmpty,
                    ),

                    const SizedBox(height: 60),

                    //Custom Keyboard
                    const NumericKeyboard(
                      maxLength: 4,
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  //カウントインWidget
  Widget countIn(int count) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                maxCount,
                (index) => SizedBox(
                  height: 32,
                  width: 32,
                  child: index < count
                      ? const Icon(
                          Icons.check_circle_outline_sharp,
                          size: 32,
                          color: Color.fromRGBO(81, 133, 213, 1),
                        )
                      : const Icon(Icons.circle_outlined,
                          size: 32, color: Colors.black),
                ),
              ),
            )),
          ),
          //Custom Keyboard
          const NumericKeyboard(
            ignoreGesture: true,
          ),
        ],
      ),
    );
  }
}
