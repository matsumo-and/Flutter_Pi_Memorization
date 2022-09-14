import 'package:flutter/material.dart';

@immutable
class ExcersiseCourse {
  final int id;
  final String title;
  final String caption;
  final List<int> multiplierList;
  final List<int> multiplicandList;

  const ExcersiseCourse({
    required this.id,
    required this.title,
    required this.caption,
    required this.multiplierList,
    required this.multiplicandList,
  });

  static List<ExcersiseCourse> list() {
    final List<ExcersiseCourse> tmpList = [];

    //10台〜９０台同士のかけ算コース
    for (int i = 1; i < 10; i++) {
      tmpList.add(ExcersiseCourse(
        id: 1000 + i,
        title: '${i}0台の数同士',
        caption: '${i}0x${i}0     ${i}4x${i}5     ${i}9x${i}9',
        multiplierList: List<int>.generate(9, (index) => i * 10 + index),
        multiplicandList: List<int>.generate(9, (index) => i * 10 + index),
      ));
    }

    return tmpList;
  }
}
