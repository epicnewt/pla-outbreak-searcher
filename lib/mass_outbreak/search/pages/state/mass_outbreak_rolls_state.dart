import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

const rollsToCompletion = {
  0: [false, false, false],
  1: [true, false, false],
  2: [false, true, false],
  3: [true, true, false],
  4: [true, false, true],
  6: [true, true, true]
};

class MassOutbreakRollsState extends ChangeNotifier {
  late List<bool> _dexCompletion = [];
  final int _rolls;

  MassOutbreakRollsState({int rolls = 26}):
      _rolls = rolls;

  int get rolls =>
      26 + _dexCompletion.mapIndexed((index, element) => element ? index + 1 : 0).sum;

  List<bool> get dexCompletion {
    if (_dexCompletion.isEmpty) {
      _dexCompletion = List.from((rollsToCompletion[_rolls - 26] ?? [false, false, false]));
    }
    return _dexCompletion;
  }

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
