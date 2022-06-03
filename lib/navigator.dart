import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';

abstract class AppRouteNavigator {
  toMOSearch(BuildContext context);
  toMOSearchResults(BuildContext context, List<MassOutbreakResult> matches);
  toMOSearchResultSpawns(BuildContext context, MassOutbreakResult result);

  toMMOSearch(BuildContext context);
  toMMOSearchResults(BuildContext context, List<MMOSearchResults> param);
  toMMOSearchResultDetails(BuildContext context, MMOSearchResults param);
  toMMOSearchResultSpawns(BuildContext context, PathSpawnInfo param);

  static AppRouteNavigator provide() => GetIt.I.get<AppRouteNavigator>();

}

class DefaultAppRouteNavigator implements AppRouteNavigator {
  static void register() => GetIt.I.registerSingleton<AppRouteNavigator>(DefaultAppRouteNavigator());

  @override
  toMOSearch(BuildContext context) {
    Navigator.popAndPushNamed(context, 'mo-search');
  }

  @override
  toMOSearchResults(BuildContext context, List<MassOutbreakResult> matches) {
    Navigator.popAndPushNamed(context, 'mo-search-results', arguments: matches);
  }
  
  @override
  toMOSearchResultSpawns(BuildContext context, MassOutbreakResult result) {
    Navigator.popAndPushNamed(context, 'mo-search-result-spawns', arguments: result);
  }

  @override
  toMMOSearch(BuildContext context) {
    Navigator.popAndPushNamed(context, 'mmo-search');
  }

  @override
  toMMOSearchResults(BuildContext context, List<MMOSearchResults> param) {
    Navigator.pushNamed(context, 'mmo-search-results', arguments: param);
  }

  @override
  toMMOSearchResultDetails(BuildContext context, MMOSearchResults param) {
    Navigator.pushNamed(context, 'mmo-search-results-details', arguments: param);
  }

  @override
  toMMOSearchResultSpawns(BuildContext context, PathSpawnInfo param) {
    Navigator.pushNamed(context, 'mmo-search-result-spawns', arguments: param);
  }
}
