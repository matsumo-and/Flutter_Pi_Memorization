import 'dart:async';

import 'package:flutter/material.dart';

enum CalculationMode {
  practice,
  beginner,
  professional,
}

extension CalculationLimit on CalculationMode {
  int get limit {
    switch (this) {
      case CalculationMode.practice:
        return 0;
      case CalculationMode.beginner:
        return 60;
      case CalculationMode.professional:
        return 20;
    }
  }
}

extension CalculationTimer on CalculationMode {
  Timer? get timer {
    switch (this) {
      case CalculationMode.practice:
        return null;
      case CalculationMode.beginner:
        return Timer.periodic(Duration(seconds: CalculationMode.beginner.limit),
            (timer) {
          print('a');
        });
      case CalculationMode.professional:
        return Timer.periodic(Duration(seconds: CalculationMode.beginner.limit),
            (timer) {
          print('a');
        });
    }
  }
}
