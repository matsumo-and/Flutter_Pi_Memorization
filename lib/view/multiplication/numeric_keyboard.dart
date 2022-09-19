import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class NumericKeyboard extends StatelessWidget {
  const NumericKeyboard({Key? key}) : super(key: key);

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
            .map((element) =>
                keyCap(text: element.toString(), onTextInput: (_) {}))
            .toList(),
      ),
    );
  }

  Widget buildRowTwo() {
    const firstElement = [4, 5, 6];
    return Expanded(
      child: Row(
        children: firstElement
            .map((element) =>
                keyCap(text: element.toString(), onTextInput: (_) {}))
            .toList(),
      ),
    );
  }

  Widget buildRowThree() {
    const firstElement = [1, 2, 3];
    return Expanded(
      child: Row(
        children: firstElement
            .map((element) =>
                keyCap(text: element.toString(), onTextInput: (_) {}))
            .toList(),
      ),
    );
  }

  Widget buildRowFour() {
    const firstElement = ['C', 0, 'BS'];
    return Expanded(
      child: Row(
        children: firstElement
            .map((element) =>
                keyCap(text: element.toString(), onTextInput: (_) {}))
            .toList(),
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
          onTap: () {},
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
