import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pickerController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/pi_memorization/pi.dart';

class PiView extends ConsumerWidget {
  final ScrollController controller;
  const PiView({Key? key, required this.controller}) : super(key: key);

  static final Border _border = Border.all(width: 0.5, color: Colors.grey);
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(13));
  static const double _fontSize = 28;
  static const EdgeInsets _letterMargin = EdgeInsets.symmetric(vertical: 10);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickerState = ref.watch(pickerProvider);

    //桁数に応じた円周率を10文字ごとに分けてリストに格納する
    final String pi = Pi.fullDigits
        .substring(pickerState.digitsFrom - 1, pickerState.digitsTo);
    final RegExp regExp = RegExp(r'(\d{10})(?=(\d{10})+)');
    final List<String> result =
        pi.replaceAllMapped(regExp, ((match) => '${match[1]}\n')).split('\n');

    List<Widget> viewList() {
      List<Widget> tmpList = [];
      //Paddingを追加
      tmpList.add(const SizedBox(height: 15));

      //一番目のモードであれば整数部分を表示する
      if (pickerState.digitsFrom == 1) {
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
      //サイズをlette6行分　＋　上下のPaddingに設定する
      height: (_fontSize + _letterMargin.bottom * 2) * 6 + 30,
      child: Scrollbar(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: viewList(),
          ),
        ),
      ),
    );
  }

  Widget letterWidget(BuildContext context, String letter) {
    return Container(
      margin: _letterMargin,
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
