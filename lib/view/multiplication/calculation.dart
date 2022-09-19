import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'package:flutter_pi_memorization/view/multiplication/numeric_keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../gradient_text_button.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({Key? key}) : super(key: key);

  @override
  CalculationPageState createState() => CalculationPageState();
}

class CalculationPageState extends State<CalculationPage>
    with TickerProviderStateMixin {
  late TextEditingController controller;
  late AnimationController animationController;

  @override
  void initState() {
    controller = TextEditingController(text: '12345');
    animationController = AnimationController(vsync: this, value: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('1/10問目')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color: Color.fromRGBO(81, 133, 213, 1),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 8,
                  width: MediaQuery.of(context).size.width - 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(236, 239, 241, 1),
                      color: const Color.fromRGBO(81, 133, 213, 1),
                      value: animationController.value,
                    ),
                  ),
                ),
                Text(
                  '30',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.caption!.color),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '10 × 12',
                style: TextStyle(fontSize: 40),
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
                        readOnly: true,
                        enabled: false,
                        maxLength: 5,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
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
              GradientTextButton(
                title: '回答する',
                height: 45,
                width: 145,
                onPressed: () {},
                disabled: false,
              ),
              const SizedBox(height: 60),
              const NumericKeyboard(),
            ],
          ),
        ],
      ),
    );
  }
}
