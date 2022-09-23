import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/calculation_controller.dart';
import 'package:flutter_pi_memorization/controller/numeric_keyboard_controller.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_pi_memorization/view/multiplication/progress_bar.dart';
import 'package:flutter_pi_memorization/view/multiplication/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/multiplication/calculation_state.dart';
import '../../model/multiplication/medal.dart';
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

  @override
  void initState() {
    //引数のIDを受け取ってランダムな掛け算問題を生成する.
    //ここで初めてInitializeしてStateの中身を決めるためビルド中には行えないらしい
    //そのためビルド後にInitializeする
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(calculationProvider.notifier)
          .initialize(id: widget.id, mode: widget.mode);
      ref.read(keyboardProvider.notifier).clear();

      ref.read(timerProvider.notifier).start(
          mode: widget.mode,
          onTimerEnd: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    ResultPage(id: widget.id, mode: widget.mode)));
          });
    });

    super.initState();
  }

  @override
  void deactivate() {
    ref.read(timerProvider.notifier).stop();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardState = ref.watch(keyboardProvider);
    final keyboardStateNotifier = ref.read(keyboardProvider.notifier);

    //ビルド後にInitializeするため State.last は例外を吐く可能性がある（実行時エラー）
    final questionState = ref.watch(calculationProvider);
    final currentQuestion =
        questionState.isEmpty ? const CalculationState() : questionState.last;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('${currentQuestion.index}/$maxQuestionNum問目')),
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
                          fontSize: 40, color: Color.fromRGBO(77, 77, 77, 0.4)),
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
                      style:
                          TextStyle(fontSize: 40, color: Colors.transparent)),
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
                            secElapsed: 12,
                            onComplete: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ResultPage(
                                          id: widget.id, mode: widget.mode)));
                            });

                        //テキスト内容を初期化する
                        keyboardStateNotifier.clear();
                      },
                disabled: keyboardState.isEmpty,
              ),

              const SizedBox(height: 60),

              //Custom Keyboard
              const NumericKeyboard(),
            ],
          ),
        ],
      ),
    );
  }
}
