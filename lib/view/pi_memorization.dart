import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';

class PiMemorization extends StatelessWidget {
  const PiMemorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(title: Text("円周率")),
      body: Container(),
    );
  }
}
