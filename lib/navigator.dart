import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRouteNavigator {
  String getDefaultRoute();

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
  String getDefaultRoute() {
    SharedPreferences sharedPreferences = GetIt.I.get();
    return sharedPreferences.getString("default-route") ?? "mmo-search";
  }

  void setDefaultRoute(String newDefault) {
    SharedPreferences sharedPreferences = GetIt.I.get();
    sharedPreferences.setString("default-route", newDefault);
  }

  @override
  toMOSearch(BuildContext context) {
    _pushRoot(context, 'mo-search');
  }

  @override
  toMOSearchResults(BuildContext context, List<MassOutbreakResult> matches) {
    Navigator.pushNamed(context, 'mo-search-results', arguments: matches);
  }

  @override
  toMOSearchResultSpawns(BuildContext context, MassOutbreakResult result) {
    Navigator.pushNamed(context, 'mo-search-result-spawns', arguments: result);
  }

  @override
  toMMOSearch(BuildContext context) {
    _pushRoot(context, 'mmo-search');
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

  void _pushRoot(BuildContext context, String route) {
    Navigator.popAndPushNamed(context, route);
    setDefaultRoute(route);
  }
}
