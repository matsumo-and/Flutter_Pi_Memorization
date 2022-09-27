import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CalculationMode {
  none,
  beginner,
  professional,
}

extension MedalExt on CalculationMode {
  Widget svgIcon(String fileName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        'assets/$fileName',
        width: 40,
        height: 40,
      ),
    );
  }

  Widget get medal {
    switch (this) {
      case CalculationMode.none:
        return svgIcon('medal.none.svg');
      case CalculationMode.beginner:
        return svgIcon('medal.beginner.svg');
      case CalculationMode.professional:
        return svgIcon('medal.professional.svg');
    }
  }

  int? get timeLimit {
    switch (this) {
      case CalculationMode.none:
        return null;
      case CalculationMode.beginner:
        return 60;
      case CalculationMode.professional:
        return 20;
    }
  }
}
