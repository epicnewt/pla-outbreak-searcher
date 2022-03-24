import 'package:mmo_searcher/mass_outbreak/search/model/filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';

abstract class MassOutbreakSearcher {
  Future<MassOutbreakInformation> getMassOutbreakInformation();
  Future<SearchResult> search(MassOutbreakInformation moInfo, Filters filters);
  dispose();
}
