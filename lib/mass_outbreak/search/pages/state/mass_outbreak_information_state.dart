import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

import '../../model/mass_outbreak_information.dart';

class MassOutbreakInformationState extends ChangeNotifier {
  bool loading = false;
  MassOutbreakInformation massOutbreakInformation = MassOutbreakInformation.empty();

  PokedexEntry? getPokemon() {
    return pokedex[massOutbreakInformation.species];
  }

  updateMassOutbreakInformation(MassOutbreakInformation info) {
    loading = false;
    massOutbreakInformation = info;
    notifyListeners();
  }

  refreshNotification(Future<MassOutbreakInformation> infoLoader) {
    loading = true;
    massOutbreakInformation = MassOutbreakInformation.empty();
    notifyListeners();
    infoLoader.then((value) {
      updateMassOutbreakInformation(value);
    }).catchError((err) {
      loading = false;
      notifyListeners();
    });
  }
}
