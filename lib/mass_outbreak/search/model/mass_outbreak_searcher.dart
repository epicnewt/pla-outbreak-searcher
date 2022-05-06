import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';

abstract class MassOutbreakSearcherService {
  Future<List<MassOutbreakInformation>> gatherOutbreakInformation();
  Future<List<MassOutbreakResult?>> performSearch(MassOutbreakSearchData info);

  static MassOutbreakSearcherService provide() {
    return GetIt.I.get<MassOutbreakSearcherService>();
  }
}
