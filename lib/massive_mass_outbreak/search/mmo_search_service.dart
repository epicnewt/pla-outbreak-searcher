import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';

abstract class MMOSearchService {
  Future<List<MMOInfo>> gatherOutbreakInformation();
  Future<List<MMOSearchResults>> performSearch(List<MMOInfo> outbreaks);

  static MMOSearchService provide() {
    return GetIt.I.get<MMOSearchService>();
  }
}
