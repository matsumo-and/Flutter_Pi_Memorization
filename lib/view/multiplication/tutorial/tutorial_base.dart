import 'package:flutter/material.dart';

class TutorialBase extends StatelessWidget {
  final String title;
  final String example;
  final List<Widget> steps;
  const TutorialBase(
      {Key? key,
      required this.title,
      required this.example,
      required this.steps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チュートリアル'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5),
            child: Text(
              '$titleの解き方のコツ',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              '例:$example',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 25),
          for (int length = 0; length < steps.length; length++)
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 15, right: 5, left: 5),
              child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step: $length',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Align(
                            alignment: Alignment.center, child: steps[length]),
                      ],
                    ),
                  )),
            )
        ],
      )),
    );
  }
}
