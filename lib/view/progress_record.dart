import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';

class ProgressRecord extends StatelessWidget {
  const ProgressRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        title: Text('記録'),
      ),
      body: Container(),
    );
  }
}
