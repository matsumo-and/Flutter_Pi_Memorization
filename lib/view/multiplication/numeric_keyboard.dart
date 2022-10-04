import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/numeric_keyboard_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumericKeyboard extends ConsumerWidget {
  final bool ignoreGesture;
  final bool backSpaceEnabled;
  final bool clearEnabled;
  final int? maxLength;
  const NumericKeyboard({
    Key? key,
    this.ignoreGesture = false,
    this.backSpaceEnabled = true,
    this.clearEnabled = true,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardStateNotifier = ref.read(keyboardProvider.notifier);

    const borderColor = Color.fromRGBO(33, 33, 33, 0.2);

    Widget buildRowOne() {
      const firstElement = [7, 8, 9];
      return Expanded(
        child: Row(
          children: firstElement
              .map((element) => keyCap(
                  text: element.toString(),
                  onTextInput: (value) => keyboardStateNotifier.insert(
                      value: value, maxLength: maxLength)))
              .toList(),
        ),
      );
    }

    Widget buildRowTwo() {
      const firstElement = [4, 5, 6];
      return Expanded(
        child: Row(
          children: firstElement
              .map((element) => keyCap(
                  text: element.toString(),
                  onTextInput: (value) => keyboardStateNotifier.insert(
                      value: value, maxLength: maxLength)))
              .toList(),
        ),
      );
    }

    Widget buildRowThree() {
      const firstElement = [1, 2, 3];
      return Expanded(
        child: Row(
          children: firstElement
              .map((element) => keyCap(
                  text: element.toString(),
                  onTextInput: (value) => keyboardStateNotifier.insert(
                      value: value, maxLength: maxLength)))
              .toList(),
        ),
      );
    }

    Widget buildRowFour() {
      return Expanded(
        child: Row(children: [
          clearEnabled
              ? keyCap(
                  text: 'C', onTextInput: (_) => keyboardStateNotifier.clear())
              : keyCap(text: '', onTextInput: (_) {}),
          keyCap(
              text: '0',
              onTextInput: (value) => keyboardStateNotifier.insert(
                  value: value, maxLength: maxLength)),
          backSpaceEnabled
              ? keyCap(
                  text: 'BS',
                  onTextInput: (_) => keyboardStateNotifier.backSpace())
              : keyCap(text: '', onTextInput: (_) {}),
        ]),
      );
    }

    return IgnorePointer(
      //キーボードを押させたくない時Trueに設定する
      ignoring: ignoreGesture,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(
              color: borderColor,
              width: 0.5,
            )),
            child: Column(
              children: [
                buildRowOne(),
                buildRowTwo(),
                buildRowThree(),
                buildRowFour(),
              ],
            ),
          ),

          //セーフゾーンを避ける
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  Widget keyCap({
    required String text,
    required ValueSetter<String> onTextInput,
  }) {
    const borderColor = Color.fromRGBO(33, 33, 33, 0.2);

    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
          color: borderColor,
          width: 0.5,
        )),
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            onTextInput(text);
          },
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
      ),
    );
  }
}
