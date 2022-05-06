import 'package:flutter/material.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:provider/provider.dart';

class MassOutbreakSearchData extends ChangeNotifier {
  bool _shiny = true;
  bool _alpha = true;
  bool _male = true;
  bool _female = true;
  bool _multimatch = true;

  List<MassOutbreakInformation>? _moInfo;

  MassOutbreakSearchData();

  bool get shiny => _shiny;
  bool get alpha => _alpha;
  bool get male => _male;
  bool get female => _female;
  bool get multimatch => _multimatch;

  update(bool shiny, bool alpha, bool male, bool female, bool multimatch) {
    _shiny = shiny;
    _alpha = alpha;
    _male = male;
    _female = female;
    _multimatch = multimatch;
    notifyListeners();
  }

  List<MassOutbreakInformation>? get moInfo => _moInfo;

  set moInfo(List<MassOutbreakInformation>? moInfo) {
    _moInfo = moInfo;
    notifyListeners();
  }

  static MassOutbreakSearchData provide(BuildContext context) {
    return Provider.of<MassOutbreakSearchData>(context, listen: false);
  }
}
