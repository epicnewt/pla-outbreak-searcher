import 'package:mmo_searcher/mass_outbreak/search/model/filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';

abstract class MassOutbreakSearcher {
  Future<MassOutbreakInformation> getMassOutbreakInformation();
  Future<SearchResult> search(MassOutbreakInformation moInfo, Filters filters, int rolls, bool multimatch, void Function(MassOutbreakResult?) onMatch, Function onTick);
  dispose();
}
