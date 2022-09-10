import 'package:flutter/material.dart';

class Tabs {
  final Widget _widget;
  final String _label;
  final Icon _icon;
  const Tabs(this._widget, this._label, this._icon);

  Widget get widget => _widget;
  String get label => _label;
  Icon get icon => _icon;
}
