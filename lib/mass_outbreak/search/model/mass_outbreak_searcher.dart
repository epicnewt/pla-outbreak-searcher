import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';

// TODO rename to MassOutbreakSearcherService
abstract class MassOutbreakSearcher {
  Future<MassOutbreakInformation> gatherOutbreakInformation();
  Future<SearchResult> performSearch(MassOutbreakInformation moInfo, MassOutbreakSearchData filters, int rolls, bool multimatch, void Function(MassOutbreakResult?) onMatch, Function onTick);

  static MassOutbreakSearcher provide() {
    return GetIt.I.get<MassOutbreakSearcher>();
  }
}
