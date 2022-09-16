import 'package:flutter/material.dart';

@immutable
class Course {
  final int id;
  final String title;
  final String caption;
  final List<int> multiplierList;
  final List<int> multiplicandList;

  const Course({
    required this.id,
    required this.title,
    required this.caption,
    required this.multiplierList,
    required this.multiplicandList,
  });

  //本番用のかけ算コース
  static Course act = Course(
    id: 1000,
    title: '99x99までのランダムなかけ算',
    caption: '11x18     99x14     32x32',
    multiplierList: List<int>.generate(99, (index) => index),
    multiplicandList: List<int>.generate(99, (index) => index),
  );

  //演習用のかけ算コース
  static List<Course> exercise() {
    final List<Course> tmpList = [];

    //10台〜９０台同士のかけ算コース
    for (int i = 1; i < 10; i++) {
      tmpList.add(Course(
        id: 1000 + i,
        title: '${i}0台の数同士',
        caption: '${i}0x${i}0     ${i}4x${i}5     ${i}9x${i}9',
        multiplierList: List<int>.generate(9, (index) => i * 10 + index),
        multiplicandList: List<int>.generate(9, (index) => i * 10 + index),
      ));
    }

    return tmpList;
  }

  static Course find(int id) {
    switch (id) {
      case 1000:
        return act;
      default:
        return exercise().firstWhere((element) => element.id == id,
            orElse: () => const Course(
                id: 0,
                title: 'title',
                caption: 'caption',
                multiplierList: [],
                multiplicandList: []));
    }
  }
}
