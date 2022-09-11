import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tabs {
  final Widget widget;
  final String label;
  final Widget inactiveIcon;
  final Widget? activeIcon;
  const Tabs(
      {required this.widget,
      required this.label,
      required this.inactiveIcon,
      this.activeIcon});

  //svgをアイコンにするための共通メソッド
  static SvgPicture activeSvgIcon({required String fileName}) {
    return SvgPicture.asset(
      'assets/$fileName',
      color: Colors.blue,
      width: 20,
      height: 20,
    );
  }

  static SvgPicture inactiveSvgIcon({required String fileName}) {
    return SvgPicture.asset(
      'assets/$fileName',
      color: Colors.grey,
      width: 20,
      height: 20,
    );
  }
}
