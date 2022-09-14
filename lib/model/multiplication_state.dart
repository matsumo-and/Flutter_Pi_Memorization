import 'package:freezed_annotation/freezed_annotation.dart';

part 'multiplication_state.freezed.dart';

@freezed
abstract class MultiplicationState with _$MultiplicationState {
  const factory MultiplicationState({
    @Default(0) int index,
    @Default(0) int multiplier,
    @Default(0) int multiplicand,
    @Default(Duration(seconds: 0)) Duration duration,
  }) = _MultiplicationState;
}
