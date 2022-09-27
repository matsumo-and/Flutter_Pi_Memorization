import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';

import '../../model/pi_memorization/pi.dart';

class PiMemorizationHome extends StatelessWidget {
  const PiMemorizationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pi50 = Pi.piAll.substring(0, 50);
    RegExp reg = RegExp(r'(\d{10})(?=(\d{10})+)');
    String mathFunc(Match match) => '${match[1]}\n';
    List<String> result = pi50.replaceAllMapped(reg, mathFunc).split('\n');

    return Scaffold(
      appBar: const HomeAppBar(title: Text("円周率")),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: result
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: e
                          .split('')
                          .map((e) => Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width / 10,
                                height: MediaQuery.of(context).size.width / 10,
                                child: Text(
                                  e,
                                  style: TextStyle(fontSize: 28),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                          .toList(),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
