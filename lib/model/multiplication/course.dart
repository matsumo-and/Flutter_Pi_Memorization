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

    //10台と９０台同士のかけ算コース
    tmpList.add(Course(
      id: 1001,
      title: '10台の数同士',
      caption: '10x10     14x15     19x19',
      multiplierList: List<int>.generate(9, (index) => 10 + index),
      multiplicandList: List<int>.generate(9, (index) => 10 + index),
    ));
    tmpList.add(Course(
      id: 1002,
      title: '90台の数同士',
      caption: '90x90     94x95     99x99',
      multiplierList: List<int>.generate(9, (index) => 90 + index),
      multiplicandList: List<int>.generate(9, (index) => 90 + index),
    ));

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
