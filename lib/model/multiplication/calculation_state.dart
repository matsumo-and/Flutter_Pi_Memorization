import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculation_state.freezed.dart';

@freezed
abstract class MultiplicationState with _$MultiplicationState {
  const factory MultiplicationState({
    @Default(0) int index,
    @Default(0) int multiplier,
    @Default(0) int multiplicand,
    @Default(false) bool isCorrect,
    @Default(0) int secElapsed,
  }) = _MultiplicationState;
}
