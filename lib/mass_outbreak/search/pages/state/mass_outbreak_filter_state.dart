import 'package:flutter/material.dart';

class MassOutbreakFilterState extends ChangeNotifier {
  bool _show = true;
  bool _shiny = true;
  bool _alpha = true;
  bool _male = true;
  bool _female = true;

  bool get show => _show;

  toggleDisplay() {
    _show = !_show;
    notifyListeners();
  }

  bool get shiny => _shiny;

  set shiny(bool value) {
    _shiny = value;
    notifyListeners();
  }

  bool get alpha => _alpha;

  set alpha(bool value) {
    _alpha = value;
    notifyListeners();
  }

  bool get male => _male;

  set male(bool value) {
    _male = value;
    if (!value) {
      female = true;
    }
    notifyListeners();
  }

  bool get female => _female;

  set female(bool value) {
    _female = value;
    if (!value) {
      male = true;
    }
    notifyListeners();
  }
}
