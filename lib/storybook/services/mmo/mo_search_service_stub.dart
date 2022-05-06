import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class MOSearchServiceStub implements MassOutbreakSearcherService {
  var _delay = const Duration(seconds: 1);

  @override
  Future<List<MassOutbreakInformation>> gatherOutbreakInformation() async {
    return Future.delayed(
      _delay,
      () => [
        MassOutbreakInformation("DA4676C773234F", 10, 25),
        MassOutbreakInformation("DA4676C773234F", 10, 26),
      ],
    );
  }

  @override
  Future<List<MassOutbreakResult?>> performSearch(MassOutbreakSearchData info) async {
    return [
      MassOutbreakResult(75643, [1, 2, 4, 4, 0, 0, 0, 0, 6], pokedex[25]!),
      MassOutbreakResult(75643, [1, 2, 4, 4, 0, 0, 0, 0, 6], pokedex[26]!),
    ];
  }

  static set delay(Duration delay) => (MassOutbreakSearcherService.provide() as MOSearchServiceStub)._delay = delay;

  static void register() {
    GetIt.I.registerSingleton<MassOutbreakSearcherService>(MOSearchServiceStub());
  }
}
