import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';

abstract class AppRouteNavigator {
  goToMMOSearchResultsPage(BuildContext context, List<MMOSearchResults> searchResults);
  goToMMOSearchResultsSummaryPage(BuildContext context, MMOSearchResults searchResults);
  goToMMOSearchResulDetailsPage(BuildContext context, PathSpawnInfo searchResults);

  static AppRouteNavigator provide() => GetIt.I.get<AppRouteNavigator>();
}

class DefaultAppRouteNavigator implements AppRouteNavigator {
  @override
  goToMMOSearchResultsPage(BuildContext context, List<MMOSearchResults> searchResults) {
    Navigator.pushNamed(context, 'mmo-search-results', arguments: searchResults);
  }

  @override
  goToMMOSearchResultsSummaryPage(BuildContext context, MMOSearchResults searchResults) {
    Navigator.pushNamed(context, 'mmo-search-results-summary', arguments: searchResults);
  }

  @override
  goToMMOSearchResulDetailsPage(BuildContext context, PathSpawnInfo searchResults) {
    Navigator.pushNamed(context, 'mmo-search-result-details', arguments: searchResults);
  }

  static void register() => GetIt.I.registerSingleton<AppRouteNavigator>(DefaultAppRouteNavigator());
}