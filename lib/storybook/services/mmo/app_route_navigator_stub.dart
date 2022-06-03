import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/navigator.dart';

// ignore_for_file: avoid_print
class AppRouteNavigatorStub implements AppRouteNavigator {
  static void register() => GetIt.I.registerSingleton<AppRouteNavigator>(AppRouteNavigatorStub());

  @override
  toMOSearch(BuildContext context) {
    print('AppRouteNavigator#toMOSearch');
  }

  @override
  toMMOSearch(BuildContext context) {
    print('AppRouteNavigator#toMMOSearch');
  }

  @override
  toMOSearchResultSpawns(BuildContext context, MassOutbreakResult result) {
    print('AppRouteNavigator#toMOSearchResultSpawns');
  }

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

  @override
  toMOSearchResults(BuildContext context, List<MassOutbreakResult> matches) {
    print('AppRouteNavigator#toMOSearchResults');
  }
}
