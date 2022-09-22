import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/multiplication/calculation_mode.dart';
import '../model/timer_state.dart';

///globalに宣言し、bottom_tab_bar.dartで初期化される
final timerProvider = StateNotifierProvider<TimerController, TimerState>((ref) {
  return TimerController(const TimerState());
});

class TimerController extends StateNotifier<TimerState> {
  TimerController(TimerState timer) : super(timer);

  late Timer timer;

  void start(CalculationMode mode) {
    //以前の状態があれば初期化する
    state = state.copyWith(secElapsed: 0);
    state = state.copyWith(secLimit: mode.limit);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(secElapsed: state.secElapsed + 1);
      final bool isTimeOver = state.secLimit! <= state.secElapsed;
      if (isTimeOver) {
        stop();
      }
    });
  }

  void stop() {
    timer.cancel();
  }
}
