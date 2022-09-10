import 'package:flutter/material.dart';

class Tabs {
  final Widget _widget;
  final String _label;
  final Widget _icon;
  const Tabs(this._widget, this._label, this._icon);

  Widget get widget => _widget;
  String get label => _label;
  Widget get icon => _icon;
}
