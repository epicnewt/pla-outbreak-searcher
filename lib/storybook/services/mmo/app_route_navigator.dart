import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/navigator.dart';

class AppRouteNavigatorStub implements AppRouteNavigator {
  static void register() => GetIt.I.registerSingleton<AppRouteNavigator>(AppRouteNavigatorStub());

  @override
  goToMMOSearchResulDetailsPage(BuildContext context, PathSpawnInfo searchResults) {}

  @override
  goToMMOSearchResultsPage(BuildContext context, List<MMOSearchResults> searchResults) {}

  @override
  goToMMOSearchResultsSummaryPage(BuildContext context, MMOSearchResults searchResults) {}
}
