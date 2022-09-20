import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final TextEditingController controller;
  const NumericKeyboard({Key? key, required this.controller}) : super(key: key);

  void _addText(value) {
    if (controller.text.length <= 3) controller.text = controller.text + value;
  }

  void _backSpace() {
    final int position = controller.text.length - 1;
    if (position <= -1) {
      return;
    } else {
      controller.text = controller.text.substring(0, position);
    }
  }

  void _clear() {
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(33, 33, 33, 0.2);

    return Column(
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
    );
  }

  Widget buildRowOne() {
    const firstElement = [7, 8, 9];
    return Expanded(
      child: Row(
        children: firstElement
            .map((element) => keyCap(
                text: element.toString(),
                onTextInput: (value) => _addText(value)))
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
                onTextInput: (value) => _addText(value)))
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
                onTextInput: (value) => _addText(value)))
            .toList(),
      ),
    );
  }

  Widget buildRowFour() {
    return Expanded(
      child: Row(children: [
        keyCap(text: 'C', onTextInput: (_) => _clear()),
        keyCap(text: '0', onTextInput: (value) => _addText(value)),
        keyCap(text: 'BS', onTextInput: (value) => _backSpace())
      ]),
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
