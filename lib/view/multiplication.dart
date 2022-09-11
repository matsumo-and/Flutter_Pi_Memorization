import 'package:flutter/material.dart';

class Multiplication extends StatelessWidget {
  const Multiplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('かけ算'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
