import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';

import '../../model/pi_memorization/pi.dart';

class PiMemorizationHome extends StatelessWidget {
  const PiMemorizationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(title: Text("円周率")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TappableCard(
              height: 400,
              child: Text(Pi.piAll.substring(0, 50)),
              onTap: null,
            )
          ],
        ),
      ),
    );
  }
}
