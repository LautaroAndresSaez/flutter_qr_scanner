import 'package:flutter/widgets.dart';

class IndexProvider extends ChangeNotifier {
  int _currentOptions = 0;

  get currentOption => _currentOptions;

  set currentOption(int index) {
    if (index > 1) {
      return;
    }
    _currentOptions = index;
    notifyListeners();
  }
}
