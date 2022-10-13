import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/multiplication/calculation_state.dart';
import '../../model/multiplication/course.dart';
import '../../model/multiplication/calculation_mode.dart';

//calculation.dartで初期化される
final calculationProvider =
    StateNotifierProvider<CalculationStore, List<CalculationState>>((ref) {
  return CalculationStore([]);
});

class CalculationStore extends StateNotifier<List<CalculationState>> {
  CalculationStore(List<CalculationState> list) : super(list);
  static const maxQuestionNum = 10;
  static late int courseId;
  static late Course course;
  static late List<int> maxMaltiplierList;
  static late List<int> maxMaltiplicandList;

  void initialize({required int id, required CalculationMode mode}) {
    //コースから引数のIDを持つリストを持ってくる
    state = [];
    courseId = id;
    course = Course.find(id);
    maxMaltiplierList = course.multiplierList;
    maxMaltiplicandList = course.multiplicandList;
    _getRandom();
  }

  ///かける数、掛けられる数の両方のリストから毎回ランダムなIndexを取り出してStateに保持する。
  void _getRandom() {
    final Random random = Random();

    //問題によっては乱数を使用しているため再度掛け算の候補リストを取得する
    course = Course.find(courseId);
    maxMaltiplierList = course.multiplierList;
    maxMaltiplicandList = course.multiplicandList;

    final int maxMaltiplierIndex = course.multiplierList.length;
    final int maxMaltiplicandIndex = course.multiplicandList.length;

    final randomMaltiplier = random.nextInt(maxMaltiplierIndex);
    final randomMaltiplicand = random.nextInt(maxMaltiplicandIndex);

    final addedState = CalculationState(
      index: state.isEmpty ? 1 : state.last.index + 1,
      multiplier: maxMaltiplierList[randomMaltiplier],
      multiplicand: maxMaltiplicandList[randomMaltiplicand],
    );

    state = [...state, addedState];
  }

  void submit(
      {required int userAnswer,
      required int secElapsed,
      required Function()? onComplete}) {
    final CalculationState currentCalculation = state.last;

    //採点する
    final int answer =
        currentCalculation.multiplier * currentCalculation.multiplicand;
    final bool isCorrect = answer == userAnswer ? true : false;

    final fetchedState = state.last.copyWith(
        userAnswer: userAnswer, secElapsed: secElapsed, isCorrect: isCorrect);

    //採点結果を反映してStateに再格納する
    state.removeLast();
    state = [...state, fetchedState];

    //問題が規定数に達したら引数のFunction（リザルト画面に遷移）を実行
    //そうでなければもう一問出題する
    if (state.length >= maxQuestionNum) {
      onComplete!();
    } else {
      _getRandom();
    }
  }
}
