import 'package:flutter/material.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/mass_outbreak_search.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/mass_outbreak_search_result.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/massive_mass_outbreak_pointer_debug_screen.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/connect_and_search_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_result_details_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_result_spawns_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_results_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_search_service.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/massive_mass_outbreak/state/massive_mass_outbreak_state.dart';
import 'package:mmo_searcher/navigator.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/simple_routed_widget.dart';
import 'package:provider/provider.dart';

void main() {
  DefaultAppRouteNavigator.register();
  DefaultMMOSearchService.register();
  PokedexStore.register().then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MassiveMassOutbreakData()),
      ],
      child: MaterialApp(
        title: "Pokémon Arceus Legends RNG Tools",
        initialRoute: 'mmo-search',
        // initialRoute: 'mo-search',
        routes: {
          'mo-search': (context) => dummyMassOutbreakSearch,
          'mo-search-results': (context) => const MassOutbreakSearchResult(),
          'mmo-pointer-debug': (context) => const MassiveMassOutbreakPointerDebugScreen(),
          'mmo-search': (context) => const ConnectAndSearchPage(),
          'mmo-search-results': (context) {
            return SimpleRoutedWidget<List<MMOSearchResults>>(
              builder: (context, argument) => MMOSearchResultsPage(searchResults: argument),
            );
          },
          'mmo-search-results-details': (context) {
            return SimpleRoutedWidget<MMOSearchResults>(
              builder: (context, argument) => MMOSearchResultDetailsPage(searchResults: argument),
            );
          },
          'mmo-search-result-spawns': (context) {
            return SimpleRoutedWidget<PathSpawnInfo>(
              builder: (context, argument) => MMOSearchResultSpawnsPage(match: argument),
            );
          },
        },
      ),
    ));
  });
}
