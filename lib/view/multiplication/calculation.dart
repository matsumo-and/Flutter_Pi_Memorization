import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pi_memorization/controller/calculation_store.dart';
import 'package:flutter_pi_memorization/model/multiplication/calculation_mode.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_pi_memorization/view/multiplication/progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/multiplication/calculation_state.dart';
import '../gradient_text_button.dart';

class CalculationPage extends ConsumerStatefulWidget {
  final int id;
  final CalculationMode mode;
  const CalculationPage({Key? key, required this.id, required this.mode})
      : super(key: key);

  @override
  CalculationPageState createState() => CalculationPageState();
}

class CalculationPageState extends ConsumerState<CalculationPage>
    with TickerProviderStateMixin {
  late TextEditingController controller;

  static const maxQuestionNum = 10;

  @override
  void initState() {
    controller = TextEditingController();

    //Submit ButtonのEnableを文字数で変えるために、暫定１文字ごとSetStateしてる
    controller.addListener(() {
      setState(() {});
    });

    //引数のIDを受け取ってランダムな掛け算問題を生成する.
    //ここで初めてInitializeしてStateの中身を決めるためビルド中には行えないらしい
    //そのためビルド後にInitializeする
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(calculationProvider.notifier).initialize(id: widget.id);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ビルド後にInitializeするため State.last は例外を吐く可能性がある（実行時エラー）
    final currentState = ref.watch(calculationProvider);
    final currentQuestion =
        currentState.isEmpty ? const CalculationState() : currentState.last;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('${currentQuestion.index}/$maxQuestionNum問目')),
      body: Stack(
        children: [
          //タイマーのプログレスバー。練習モード以外なら表示する
          Visibility(
            visible: widget.mode != CalculationMode.practice,
            child: ProgressBar(),
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
                  SizedBox(
                    height: 65,
                    width: 145,
                    child: Center(
                      child: TextFormField(
                        controller: controller,
                        enabled: false,
                        //readOnly: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
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
                onPressed: controller.text.isEmpty
                    ? null
                    : () {
                        //SUBMIT して次の問題を表示する
                        ref.read(calculationProvider.notifier).submit(
                            userAnswer: int.tryParse(controller.text)!,
                            secElapsed: 12);

                        //テキスト内容を初期化する
                        controller.text = '';
                      },
                disabled: controller.text.isEmpty,
              ),

              const SizedBox(height: 60),

              //Custom Keyboard
              NumericKeyboard(
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
