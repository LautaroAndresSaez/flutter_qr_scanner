import 'package:flutter/material.dart';

class NavigatorOption {
  String _label;
  IconData _icon;

  NavigatorOption(this._icon, this._label);

  get label => _label;
  get icon => _icon;
}
