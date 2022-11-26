import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/multiplication/tutorial/tutorial_base.dart';

class Tutorial1001 extends StatelessWidget {
  final String title;
  final String example;
  const Tutorial1001({Key? key, required this.title, required this.example})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> steps() {
      List<Widget> widgetList = [];
      //step0
      widgetList.add(Column(
        children: const [
          Text('掛ける数がともに10台であるか確認する。'),
          Text('12 x 16'),
        ],
      ));

      //step1
      widgetList.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('掛ける数の一方に、もう一方の1のくらいの数を足し「10」を掛ける。'),
          Text('12 x 16'),
          Icon(Icons.arrow_downward_outlined),
          Text('12 x 16'),
          Icon(Icons.arrow_downward_outlined),
          Text('12 x 16'),
        ],
      ));

      //step2
      widgetList.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('掛ける数の一の位同士を掛ける。'),
          Text('12 x 16'),
          Icon(Icons.arrow_downward_outlined),
          Text('2 x 6 = 12'),
        ],
      ));

      //step3
      widgetList.add(Column(
        children: const [
          Text('「Step1の結果」と「Step2の結果」を足し合わせる'),
          Text('12 x 16'),
          Icon(Icons.arrow_downward_outlined),
          Text('2 x 6 = 12'),
        ],
      ));
      return widgetList;
    }

    ;
    return TutorialBase(title: title, example: example, steps: steps());
  }
}
