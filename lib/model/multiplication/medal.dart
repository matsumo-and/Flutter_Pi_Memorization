import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Medal {
  none,
  beginner,
  professional,
}

extension MedalExt on Medal {
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

  Widget get icon {
    switch (this) {
      case Medal.none:
        return svgIcon('medal.none.svg');
      case Medal.beginner:
        return svgIcon('medal.beginner.svg');
      case Medal.professional:
        return svgIcon('medal.professional.svg');
    }
  }
}
