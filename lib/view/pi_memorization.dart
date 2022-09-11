import 'package:flutter/material.dart';

class PiMemorization extends StatelessWidget {
  const PiMemorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('円周率'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
