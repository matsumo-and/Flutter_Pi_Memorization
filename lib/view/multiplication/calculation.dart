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
    animationController = AnimationController(vsync: this);
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
          LinearProgressIndicator(
            color: Colors.amber,
            backgroundColor: Colors.grey,
            value: animationController.value,
            semanticsLabel: 'Linear progress indicator',
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
              const SizedBox(height: 15),
              GradientTextButton(
                title: '回答する',
                height: 45,
                width: 145,
                onPressed: () {},
                disabled: false,
              ),
              const SizedBox(height: 50),
              const NumericKeyboard(),
            ],
          ),
        ],
      ),
    );
  }
}
