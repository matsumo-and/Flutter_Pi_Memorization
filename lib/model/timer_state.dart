import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
abstract class TimerState with _$TimerState {
  const factory TimerState({
    int? secLimit,
    @Default(0) int secElapsed,
  }) = _TimerState;
}
