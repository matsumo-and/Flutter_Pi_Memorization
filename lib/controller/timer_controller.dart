import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/multiplication/calculation_mode.dart';
import '../model/timer_state.dart';

final timerProvider = StateNotifierProvider<TimerController, TimerState>((ref) {
  return TimerController(const TimerState());
});

class TimerController extends StateNotifier<TimerState> {
  TimerController(TimerState timer) : super(timer);

  late Timer timer;

  void start(
      {required CalculationMode mode, required Function()? onTimerEnd}) async {
    //以前の状態があれば初期化する
    state = state.copyWith(secElapsed: 0);
    state = state.copyWith(secLimit: mode.timeLimit);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(secElapsed: state.secElapsed + 1);
      if (isTimeOver()) {
        onTimerEnd!();
        stop();
      }
    });
  }

  void stop() {
    timer.cancel();
  }

  bool isTimeOver() {
    return state.secLimit == null ? false : state.secLimit! <= state.secElapsed;
  }
}
