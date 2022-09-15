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

  //本番用のかけ算コース
  static ExcersiseCourse act = ExcersiseCourse(
    id: 1000,
    title: '99x99までのかけ算をランダムで出題',
    caption: '11x18     99x14     32x32',
    multiplierList: List<int>.generate(99, (index) => index),
    multiplicandList: List<int>.generate(99, (index) => index),
  );

  //演習用のかけ算コース
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

  static ExcersiseCourse find(int id) {
    switch (id) {
      case 1000:
        return act;
      default:
        return list().firstWhere((element) => element.id == id,
            orElse: () => const ExcersiseCourse(
                id: 0,
                title: 'title',
                caption: 'caption',
                multiplierList: [],
                multiplicandList: []));
    }
  }
}
