import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class MOSearchServiceStub implements MassOutbreakSearcherService {
  var _delay = const Duration(seconds: 1);

  @override
  Future<MassOutbreakInformation> gatherOutbreakInformation() async {
    return Future.delayed(_delay, () => MassOutbreakInformation("DA4676C773234F", 10, 25));
  }

  @override
  Future<SearchResult> performSearch(MassOutbreakInformation moInfo, MassOutbreakSearchData filters, int rolls, bool multimatch,
      void Function(MassOutbreakResult? p1) onMatch, Function onTick) async {
    return SearchResult(75643, [1, 2, 4, 4, 0, 0, 0, 0, 6], -1, pokedex[25]!);
  }

  static set delay(Duration delay) => (MassOutbreakSearcherService.provide() as MOSearchServiceStub)._delay = delay;

  static void register() {
    GetIt.I.registerSingleton<MassOutbreakSearcherService>(MOSearchServiceStub());
  }
}
