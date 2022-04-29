import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/navigator.dart';

class AppRouteNavigatorStub implements AppRouteNavigator {
  static void register() => GetIt.I.registerSingleton<AppRouteNavigator>(AppRouteNavigatorStub());

  @override
  toMMOSearchResultSpawns(BuildContext context, PathSpawnInfo param) {
    print('AppRouteNavigator#toMMOSearchResultSpawns');
  }

  @override
  toMMOSearchResults(BuildContext context, List<MMOSearchResults> param) {
    print('AppRouteNavigator#toMMOSearchResults');
  }

  @override
  toMMOSearchResultDetails(BuildContext context, MMOSearchResults param) {
    print('AppRouteNavigator#toMMOSearchResultsDetails');
  }
}
