import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/numeric_keyboard_controller.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/model/pi_memorization/picker.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/pi_memolization/pickerController.dart';
import '../../model/pi_memorization/pi.dart';
import '../../model/pi_memorization/pi_mode.dart';
import 'result.dart';

class PiQuestion extends ConsumerStatefulWidget {
  final PiMode mode;
  const PiQuestion({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  ConsumerState<PiQuestion> createState() => PiQuestionState();
}

class PiQuestionState extends ConsumerState<PiQuestion> {
  static const int maxCount = 3;

  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(13));
  static const double _fontSize = 28;
  static const EdgeInsets _letterMargin = EdgeInsets.symmetric(vertical: 10);

  //間違えた回数を記録する
  final ValueNotifier<int> failedAnswer = ValueNotifier(0);
  late Function()? removeListener;

  //カウントインの回数を保持する
  int count = 0;

  //円周率入力時のスクロールを制御
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    //ここで初めてInitializeしてStateの中身を決めるためビルド中には行えないらしい。ビルド後にInitializeする
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //以前のキーボードの状態をクリアする
      ref.read(keyboardProvider.notifier).clear();

      //カウントインを表示してから（awaitしてから）タイマーをスタートする
      await showCountIn();
      ref.read(timerProvider.notifier).start(onTimerEnd: () {});

      checkAnswer();
    });
  }

  @override
  void deactivate() {
    //Pageが破棄されると同時にタイマーを停止する。
    ref.read(timerProvider.notifier).stop();
    //addListenerを削除
    removeListener?.call();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> showCountIn() async {
    //練習モードであればカウントインは表示しない
    if (widget.mode == PiMode.excersize) return;

    //1秒ごとカウントアップし、カウントがcountInSecを上回ったら出題画面を表示
    for (int sec = 0; sec < maxCount + 1; sec++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        count++;
      });
    }
  }

  ///ユーザーの入力が合っているかを確認する
  void checkAnswer() {
    ///正しい答えを保持する
    final pickerState = ref.read(pickerProvider);
    final String piSubstr = Pi.fullDigits
        .substring(pickerState.digitsFrom - 1, pickerState.digitsTo);
    final String correctAnswer =
        widget.mode == PiMode.act ? Pi.fullDigits : piSubstr;

    ///入力された答えを[addListener]し、正答との末尾1文字を比較する
    removeListener = ref.read(keyboardProvider.notifier).addListener((state) {
      if (state != "") {
        final String lastLetter = state.substring(state.length - 1);
        final bool isCorrect = lastLetter ==
            correctAnswer.substring(state.length - 1, state.length);

        //もし間違っていたらカウントを増加させて、入力を1文字戻す
        if (!isCorrect) {
          ref.read(keyboardProvider.notifier).backSpace();
          failedAnswer.value++;

          //規定数を超過したらリザルト画面に遷移
          if (failedAnswer.value >= widget.mode.remainingLives) {
            navigateToResult(correctDigits: state.length);
          }
        } else {
          //全部回答できたらリザルトに遷移
          if (state.length == correctAnswer.length) {
            navigateToResult(correctDigits: state.length);
          }
        }
      }
    });
  }

  void navigateToResult({required int correctDigits}) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => PiResult(
                correctDigits: correctDigits,
                mode: widget.mode,
              ))));

  @override
  Widget build(BuildContext context) {
    final pickerState = ref.watch(pickerProvider);
    final appBarSubTitle = widget.mode == PiMode.excersize
        ? ' (${pickerState.digitsFrom} ~ ${pickerState.digitsTo})'
        : '';

    return widget.mode != PiMode.excersize && count <= maxCount
        ? countIn(count)
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('${widget.mode.appBarTitle}$appBarSubTitle'),
              actions: [
                IconButton(
                    onPressed: (() {
                      navigateToResult(
                          correctDigits: ref.read(keyboardProvider).length);
                    }),
                    icon: const Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //間違えた回数を記録する
                ValueListenableBuilder<int>(
                    valueListenable: failedAnswer,
                    builder: (context, value, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            widget.mode.remainingLives,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Icon(
                                    Icons.close,
                                    color: index < value
                                        ? const Color.fromRGBO(224, 70, 45, 1)
                                        : const Color.fromRGBO(
                                            196, 196, 196, 1),
                                    size: 32,
                                  ),
                                )).toList(),
                      );
                    }),

                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: _borderRadius,
                      color: Color.fromRGBO(250, 250, 250, 1),
                    ),
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    width: MediaQuery.of(context).size.width,
                    //サイズをlette6行分　＋　上下のPaddingに設定する
                    height: (_fontSize + _letterMargin.bottom * 2) * 6 + 30,
                    child: Scrollbar(
                      controller: controller,
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          children: viewList(pickerState),
                        ),
                      ),
                    ),
                  ),
                ),

                //Custom Keyboard
                NumericKeyboard(
                  //入力できる最大文字数はPickerで選んだ桁数分
                  maxLength: pickerState.digitsTo - pickerState.digitsFrom + 1,
                  backSpaceEnabled: false,
                  clearEnabled: false,
                ),
              ],
            ),
          );
  }

  //カウントインWidget
  Widget countIn(int count) {
    const double iconSize = 32;
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
                  height: iconSize,
                  width: iconSize,
                  child: index < count
                      ? const Icon(
                          Icons.check_circle_outline_sharp,
                          size: iconSize,
                          color: Color.fromRGBO(81, 133, 213, 1),
                        )
                      : const Icon(Icons.circle_outlined,
                          size: iconSize, color: Colors.black),
                ),
              ),
            )),
          ),
          //Custom Keyboard
          const NumericKeyboard(
            ignoreGesture: true,
            backSpaceEnabled: false,
            clearEnabled: false,
          ),
        ],
      ),
    );
  }

  ///円周率出題画面
  List<Widget> viewList(PickerState pickerState) {
    final String answer = Pi.fullDigits
        .substring(pickerState.digitsFrom - 1, pickerState.digitsTo);

    //桁数に応じた円周率を10文字ごとに分けてリストに格納する
    final keyboardState = ref.watch(keyboardProvider);
    final RegExp regExp = RegExp(r'(\d{10})(?=(\d)+)');
    final List<String> result = keyboardState
        .replaceAllMapped(regExp, ((match) => '${match[1]}\n'))
        .split('\n');

    //入力された数を1文字ごとに分けてWidgetに格納する
    Widget letterWidget(BuildContext context, String letter) {
      return Container(
        margin: _letterMargin,
        width: _fontSize,
        height: _fontSize,
        child: Text(
          letter == '' ? '・' : letter,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: _fontSize,
                color: letter == '' ? Colors.grey : Colors.black,
              ),
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      );
    }

    //問題範囲の円周率を10文字ごと区切った時の列数を取得
    int maxLength = (answer.length / 10).ceil();

    //返却するためのWigdetリストを作成
    List<Widget> viewList = [];

    //Paddingを追加し、必要列数を１つ増やす
    viewList.add(const SizedBox(height: 15));
    maxLength++;

    //一番目のモードであれば整数部分を表示, 必要列数を１増加
    if (pickerState.digitsFrom == 1) {
      viewList.add(Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: letterWidget(context, '3.'),
          )));
      maxLength++;
    }

    //１０文字ごと区切った各列に対して、更に1文字ずつ分割して画面に均等に配置する
    for (String line in result) {
      final List<Widget> letterList = line
          .split('')
          .map((letter) => letterWidget(context, letter))
          .toList();

      //文字数が足りなければ10文字になるようにドットを加える
      while (letterList.length < 10) {
        letterList.add(letterWidget(context, ''));
      }

      viewList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: letterList));
    }

    //列数が足りなければ（まだ入力する必要があれば）一列分ドット列を加える
    if (viewList.length < maxLength) {
      viewList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(10, (index) => letterWidget(context, ''))));
    }

    //Paddingを追加
    viewList.add(const SizedBox(height: 15));

    //再描画時に入力時に可能な限り下にスクロールする
    if (controller.hasClients &&
        controller.offset != controller.position.maxScrollExtent) {
      controller.animateTo(controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn);
    }
    return viewList;
  }
}
