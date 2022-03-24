
import 'package:mmo_searcher/mass_outbreak/search/model/filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';

class DummyMassOutbreakSearcher implements MassOutbreakSearcher {
  @override
  Future<MassOutbreakInformation> getMassOutbreakInformation() async {
    return Future.delayed(const Duration(seconds: 1), () => MassOutbreakInformation("2E2B6AFB84F888DB", 10, 200));
  }

  @override
  Future<SearchResult> search(MassOutbreakInformation moInfo, Filters filters, int rolls) {
    return Future.delayed(const Duration(seconds: 1), () => SearchResult(BigInt.parse("2E2B6AFB84F888DB", radix: 16), [0,0,0,1,3,-2], 26));
  }

  @override
  dispose() {
  }
}