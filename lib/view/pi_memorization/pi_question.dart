import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/numeric_keyboard_controller.dart';
import 'package:flutter_pi_memorization/controller/timer_controller.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/pi_memolization/pickerController.dart';
import '../../model/pi_memorization/pi.dart';
import '../../model/pi_memorization/pi_mode.dart';

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

  //カウントインの回数を保持する
  int count = 0;

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
    });
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
    if (widget.mode == PiMode.excersize) return;

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

    final pickerState = ref.watch(pickerProvider);
    final appBarSubTitle = widget.mode == PiMode.excersize
        ? ' (${pickerState.digitsFrom} ~ ${pickerState.digitsTo})'
        : '';

    final String answer = Pi.fullDigits
        .substring(pickerState.digitsFrom - 1, pickerState.digitsTo);

    //桁数に応じた円周率を10文字ごとに分けてリストに格納する
    final RegExp regExp = RegExp(r'(\d{10})(?=(\d)+)');
    final List<String> result = keyboardState
        .replaceAllMapped(regExp, ((match) => '${match[1]}\n'))
        .split('\n');

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

    List<Widget> viewList() {
      //問題範囲の円周率を10文字ごと区切った時の列数を取得
      int maxLength = (answer.length / 10).ceil();
      List<Widget> tmpList = [];

      //Paddingを追加し、必要列数を１つ増やす
      tmpList.add(const SizedBox(height: 15));
      maxLength++;

      //一番目のモードであれば整数部分を表示, 必要列数を１増加
      if (pickerState.digitsFrom == 1) {
        tmpList.add(Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: letterWidget(context, '3.'),
            )));
        maxLength++;
      }

      //各10文字ごとの列に対して、更に1文字ずつ分割して画面に均等に配置する
      for (String line in result) {
        final List<Widget> letterList = line
            .split('')
            .map((letter) => letterWidget(context, letter))
            .toList();

        //10文字になるようにドットを加える
        while (letterList.length < 10) {
          letterList.add(letterWidget(context, ''));
        }

        tmpList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: letterList));
      }

      //列数が足りなければ（まだ入力する必要があれば）一列分ドット列を加える
      if (tmpList.length < maxLength) {
        tmpList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(10, (index) => letterWidget(context, ''))));
      }

      //Paddingを追加
      tmpList.add(const SizedBox(height: 15));

      //入力時に可能な限り下にスクロールする
      if (controller.hasClients &&
          controller.offset != controller.position.maxScrollExtent) {
        controller.animateTo(controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.fastOutSlowIn);
      }
      return tmpList;
    }

    return widget.mode != PiMode.excersize && count <= maxCount
        ? countIn(count)
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Text('${widget.mode.appBarTitle}$appBarSubTitle')),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: _borderRadius,
                      color: Color.fromRGBO(250, 250, 250, 1),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    width: MediaQuery.of(context).size.width,
                    //サイズをlette6行分　＋　上下のPaddingに設定する
                    height: (_fontSize + _letterMargin.bottom * 2) * 6 + 30,
                    child: Scrollbar(
                      controller: controller,
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          children: viewList(),
                        ),
                      ),
                    ),
                  ),
                ),

                //Custom Keyboard
                NumericKeyboard(
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
            backSpaceEnabled: false,
            clearEnabled: false,
          ),
        ],
      ),
    );
  }
}
