import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculation_state.freezed.dart';

@freezed
abstract class CalculationState with _$CalculationState {
  const factory CalculationState({
    @Default(0) int index,
    @Default(0) int multiplier,
    @Default(0) int multiplicand,
    @Default(0) int userAnswer,
    @Default(false) bool isCorrect,
    @Default(0) int secElapsed,
  }) = _CalculationState;
}
