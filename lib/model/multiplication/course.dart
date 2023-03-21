import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/multiplication/tutorial/tutorial_1001.dart';
import 'package:flutter_pi_memorization/view/multiplication/tutorial/tutorial_base.dart';

@immutable
class Course {
  final int id;
  final String title;
  final String caption;
  final List<int> multiplierList;
  final List<int> multiplicandList;
  //チュートリアル文章用
  final Widget tutorial;

  const Course({
    required this.id,
    required this.title,
    required this.caption,
    required this.multiplierList,
    required this.multiplicandList,
    required this.tutorial,
  });

  //本番用のかけ算コース
  static Course act = Course(
    id: 1000,
    title: '99x99までのランダムなかけ算',
    caption: '11x18     99x14     32x32',
    multiplierList: List<int>.generate(99, (index) => index),
    multiplicandList: List<int>.generate(99, (index) => index),
    tutorial: const Tutorial1001(
      title: '99x99までのランダムなかけ算',
      example: '12x16',
    ),
  );

  //演習用のかけ算コース
  static List<Course> exercise() {
    final List<Course> tmpList = [];

    //1~9の乱数を生成し、コースによってはこれを用いる
    final Random random = Random();
    final int random1 = random.nextInt(9) + 1;
    final int random2 = random.nextInt(9) + 1;

    //10台と９０台同士のかけ算コース
    tmpList.add(Course(
      id: 1001,
      title: '10台の数同士',
      caption: '10x10     14x15     19x19',
      multiplierList: List<int>.generate(9, (index) => 10 + index),
      multiplicandList: List<int>.generate(9, (index) => 10 + index),
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    ///初版リリースのためコメントアウト
    /*
    tmpList.add(Course(
      id: 1002,
      title: '90台の数同士',
      caption: '90x90     94x95     99x99',
      multiplierList: List<int>.generate(9, (index) => 90 + index),
      multiplicandList: List<int>.generate(9, (index) => 90 + index),
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    tmpList.add(Course(
      id: 1003,
      title: '20,30…90をはさんだ数',
      caption: '17x23     24x35     78x89',
      multiplierList: List<int>.generate(9, (index) => random1 * 10 + index),
      multiplicandList:
          List<int>.generate(9, (index) => (random1 + 1) * 10 + index),
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    tmpList.add(Course(
      id: 1004,
      title: '50に近い数同士',
      caption: '46x53     53x54     48x49',
      multiplierList: List<int>.generate(10, (index) => 45 + index),
      multiplicandList: List<int>.generate(10, (index) => 45 + index),
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    */

    tmpList.add(Course(
      id: 1005,
      title: '10の位が等しく、1の位が足して10',
      caption: '17x13     24x26     78x72',
      multiplierList: <int>[random1 * 10 + random2],
      multiplicandList: <int>[random1 * 10 + (10 - random2)],
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    tmpList.add(Course(
      id: 1006,
      title: '1の位が等しく、10の位が足して10',
      caption: '17x23     24x35     78x89',
      multiplierList: <int>[random1 * 10 + random2],
      multiplicandList: <int>[(10 - random1) * 10 + random2],
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    ///初版リリースのためコメントアウト
    /*
    tmpList.add(Course(
      id: 1007,
      title: 'かける数が25',
      caption: '17x25     24x25     78x25',
      multiplierList: List<int>.generate(99, (index) => index),
      multiplicandList: const <int>[25],
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));

    tmpList.add(Course(
      id: 1008,
      title: '偶数と1の位が5の数',
      caption: '18x25     24x25     78x25',
      multiplierList: List<int>.generate(49, (index) => index * 2),
      multiplicandList: List<int>.generate(9, (index) => index * 10 + 5),
      tutorial: const Tutorial1001(
        title: '99x99までのランダムなかけ算',
        example: '12x16',
      ),
    ));
    */

    ///11~20 x 11から
    ///11~20 x 20までを生成
    ///[id]= [1009 ~ 1017]まで発番
    for (int multiplicandCnt = 0; multiplicandCnt < 9; multiplicandCnt++) {
      tmpList.add(Course(
        id: 1009 + multiplicandCnt,
        title: '11~20 x ${11 + multiplicandCnt}',
        caption:
            '11x${11 + multiplicandCnt}     12x${11 + multiplicandCnt}     13x${11 + multiplicandCnt}',
        multiplierList: List<int>.generate(9, (index) => 11 + index),
        multiplicandList: <int>[11 + multiplicandCnt],
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
                  multiplicandList: [],
                  tutorial: TutorialBase(
                    title: 'title',
                    example: 'example',
                    steps: [],
                  ),
                ));
    }
  }
}
