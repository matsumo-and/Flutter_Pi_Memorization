import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/multiplication/calculation_state.dart';
import '../model/multiplication/course.dart';
import '../model/multiplication/medal.dart';

///globalに宣言し、bottom_tab_bar.dartで初期化される
final calculationProvider =
    StateNotifierProvider<CalculationStore, List<CalculationState>>((ref) {
  return CalculationStore([]);
});

class CalculationStore extends StateNotifier<List<CalculationState>> {
  CalculationStore(List<CalculationState> list) : super(list);

  static late Course course;
  static late List<int> maxMaltiplierList;
  static late List<int> maxMaltiplicandList;

  void initialize({required int id, required CalculationMode mode}) {
    //
    state = [];
    course = Course.find(id);
    maxMaltiplierList = course.multiplierList;
    maxMaltiplicandList = course.multiplicandList;
    _getRandom();
  }

  void _getRandom() {
    final Random random = Random();

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

    state.removeLast();
    state = [...state, fetchedState];

    if (state.length >= 10) {
      onComplete!();
    } else {
      _getRandom();
    }
  }
}
