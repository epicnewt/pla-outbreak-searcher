
import 'package:mmo_searcher/mass_outbreak/search/model/filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

class DummyMassOutbreakSearcher implements MassOutbreakSearcher {
  @override
  Future<MassOutbreakInformation> getMassOutbreakInformation() async {
    return Future.delayed(const Duration(seconds: 1), () => MassOutbreakInformation("CA34408C56C5B4B3", 15, 358));
  }

  @override
  Future<SearchResult> search(MassOutbreakInformation moInfo, Filters filters, int rolls) {
    var result = searchMassOutbreak(BigInt.parse(moInfo.seed, radix: 16), moInfo.spawns, rolls, pokedex[moInfo.species]!);
    return Future.delayed(const Duration(seconds: 1), () => SearchResult(
        result!.seed,
        result.path,
        rolls,
        pokedex[moInfo.species]!
    ));
  }

  @override
  dispose() {
  }
}