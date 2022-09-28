import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/pi_memorization/pi.dart';

class PiView extends StatelessWidget {
  final int digitsId;
  const PiView({Key? key, required this.digitsId}) : super(key: key);

  static final Border _border = Border.all(width: 0.5, color: Colors.grey);
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(13));
  static const double _fontSize = 28;

  @override
  Widget build(BuildContext context) {
    //IDに応じた桁の円周率を10文字ごとに分けてリストに格納する
    final Pi pi = Pi.getSubstring(digitsId: digitsId);
    final RegExp regExp = RegExp(r'(\d{10})(?=(\d{10})+)');
    final List<String> result = pi.substring
        .replaceAllMapped(regExp, ((match) => '${match[1]}\n'))
        .split('\n');

    List<Widget> viewList() {
      List<Widget> tmpList = [];
      //Paddingを追加
      tmpList.add(const SizedBox(height: 15));

      //一番目のモードであれば整数部分を表示する
      if (digitsId == 1) {
        tmpList.add(Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: letterWidget(context, '3.'),
            )));
      }
      //各10文字ごとの列に対して、更に1文字ずつ分割して画面に均等に配置する
      for (String line in result) {
        tmpList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: line
              .split('')
              .map((letter) => letterWidget(context, letter))
              .toList(),
        ));
      }

      //Paddingを追加
      tmpList.add(const SizedBox(height: 15));
      return tmpList;
    }

    return Container(
      decoration: BoxDecoration(
        border: _border,
        borderRadius: _borderRadius,
      ),
      margin: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: viewList(),
      ),
    );
  }

  Widget letterWidget(BuildContext context, String letter) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: _fontSize,
      height: _fontSize,
      child: Text(
        letter,
        style: GoogleFonts.inter(
            textStyle: const TextStyle(fontSize: _fontSize),
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
