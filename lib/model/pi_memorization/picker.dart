import 'package:freezed_annotation/freezed_annotation.dart';

part 'picker.freezed.dart';

@freezed
abstract class PickerState with _$PickerState {
  const factory PickerState({
    @Default(1) int digitsFrom,
    @Default(50) int digitsTo,
  }) = _PickerState;
}
