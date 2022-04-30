import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_result_spawns_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/connect_and_search_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_result_details_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_results_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_advancer.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_search_service.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/massive_mass_outbreak/state/massive_mass_outbreak_state.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_page.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:mmo_searcher/storybook/services/mmo/app_route_navigator_stub.dart';
import 'package:mmo_searcher/storybook/services/mmo/mmo_search_service_stub.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  AppRouteNavigatorStub.register();
  MMOSearchServiceStub.register();
  runApp(const StorybookApp());
}

PathSpawnInfo asSpawnInfo(MMOPath path) {
  return PathSpawnInfo([], 0, 0, EncounterTable.massoutbreak, null, path, (p) => p.alpha && p.shiny);
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        stories: [
          Story(
            name: 'MMO/Initial Page',
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: MassiveMassOutbreakData(),
                ),
              ],
              child: const ConnectAndSearchPage(),
            ),
          ),
          Story(
            name: 'MMO/Initial Page (connected)',
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) {
                    var massiveMassOutbreakData = MassiveMassOutbreakData();
                    GetIt.I.get<MMOSearchService>().gatherOutbreakInformation().then((value) => massiveMassOutbreakData.mmoInfo = value);
                    return massiveMassOutbreakData;
                  },
                ),
              ],
              child: const ConnectAndSearchPage(),
            ),
          ),
          Story(
            name: 'MMO/Result Summary Page',
            builder: (context) => FutureBuilder<List<MMOSearchResults>>(
              future: MMOSearchService.provide().gatherOutbreakInformation().then(MMOSearchService.provide().performSearch),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('loading');
                }
                return MMOSearchResultsPage(searchResults: snapshot.data!);
              },
            ),
          ),
          Story(
            name: 'MMO/Search Result Details Page',
            builder: (context) => FutureBuilder<MMOSearchResults>(
              future: MMOSearchService.provide().gatherOutbreakInformation().then(MMOSearchService.provide().performSearch).then((value) => value[0]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('loading');
                }
                return MMOSearchResultDetailsPage(searchResults: snapshot.data!);
              },
            ),
          ),
          Story(
            name: "MMO/Search Result Spawns Page",
            builder: (context) => MMOSearchResultSpawnsPage(
                match: generateSpawnsOfPath(
                    MMOPath(MutableMMOPath.withPaths([1, 2, 1, 1], [2, 1], [3])),
                    MMOInfo(
                    "",
                      BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                      9,
                      7,
                      encounterSlotsMap["D3FB11A4B88400FC"]!,
                      encounterSlotsMap["64064A0B10810230"]!,
                    ),
                    alphaRequired: false,
                    shinyRequired: true)!),
          ),
          Story(
            name: "Pokedex/Pokemon",
            builder: (context) => ListView(
              shrinkWrap: true,
              children: [
                PokedexEntrySummary(
                  pokedexEntry: randomPokedexEntry(),
                  caught: true,
                  complete: true,
                  perfect: true,
                  shinyCharm: true,
                ),
                PokedexEntrySummary(
                  pokedexEntry: randomPokedexEntry(),
                  caught: true,
                  complete: true,
                  perfect: true,
                  shinyCharm: true,
                ),
                PokedexEntrySummary(
                  pokedexEntry: randomPokedexEntry(),
                  caught: false,
                  complete: true,
                  perfect: true,
                  shinyCharm: true,
                ),
              ],
            ),
          ),
          Story(name: "Pokedex/Page", builder: (context) => const PokedexPage())
        ],
      );

  randomPokedexEntry() {
    return pokedex.values.toList()[Random().nextInt(pokedex.values.length - 1) + 1];
  }
}
