import 'package:flutter/material.dart';

class MassOutbreakRollsState extends ChangeNotifier {
  final List<bool> _dexCompletion = [false, false, false];

  int get rolls =>
      26 + //
      ((_dexCompletion[0]) ? 1 : 0) + //
      ((_dexCompletion[1]) ? 2 : 0) + //
      ((_dexCompletion[2]) ? 3 : 0);

  List<bool> get dexCompletion => _dexCompletion;

  toggleDexCompletion(int i) {
    _dexCompletion[i] = !_dexCompletion[i];
    if (i == 2) {
      if (_dexCompletion[i]) {
        _dexCompletion[0] = true;
      }
    } else if (i == 1) {
      if (_dexCompletion[i]) {
        _dexCompletion[0] = true;
      }
    } else {
      if (!_dexCompletion[0]) {
        _dexCompletion[1] = false;
        _dexCompletion[2] = false;
      }
    }
    notifyListeners();
  }
}
