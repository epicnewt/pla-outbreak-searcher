import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';

class MassiveMassOutbreakData extends ChangeNotifier {

  bool _shiny = true;
  bool _alpha = true;
  bool _multimatch = false;
  List<MMOInfo> _mmoInfo = [];

  bool get shiny => _shiny;

  set shiny(bool shiny) {
    _shiny = shiny;
    notifyListeners();
  }

  bool get alpha => _alpha;

  set alpha(bool alpha) {
    _alpha = alpha;
    notifyListeners();
  }

  bool get multimatch => _multimatch;

  set multimatch(bool multimatch) {
    _multimatch = multimatch;
    notifyListeners();
  }

  List<MMOInfo> get mmoInfo => _mmoInfo;

  set mmoInfo(List<MMOInfo> mmoInfo) {
    _mmoInfo = mmoInfo;
    notifyListeners();
  }
}