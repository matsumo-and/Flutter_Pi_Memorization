import 'package:flutter/material.dart';

class ProgressRecord extends StatelessWidget {
  const ProgressRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
