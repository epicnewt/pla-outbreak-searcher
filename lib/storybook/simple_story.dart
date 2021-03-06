import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/common/feature_switches.dart';
import 'package:mmo_searcher/mass_outbreak/pages/mo_connect_and_search_page.dart';
import 'package:mmo_searcher/mass_outbreak/pages/mo_search_result_spawns_page.dart';
import 'package:mmo_searcher/mass_outbreak/pages/mo_search_results_summary_page.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_result_spawns_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_connect_and_search_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_result_details_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/mmo_search_results_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/pokemon_sprite.dart';
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
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:mmo_searcher/storybook/services/mmo/app_route_navigator_stub.dart';
import 'package:mmo_searcher/storybook/services/mmo/mmo_search_service_stub.dart';
import 'package:mmo_searcher/storybook/services/mmo/mo_search_service_stub.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() async {
  AppRouteNavigatorStub.register();
  MMOSearchServiceStub.register();
  MOSearchServiceStub.register();
  FeatureSwitchService.register();

  await PokedexStore.register();
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
            name: 'MO/Initial Page',
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: MassOutbreakSearchData(),
                ),
              ],
              child: const MOConnectAndSearchPage(),
            ),
          ),
          Story(
            name: 'MO/Initial Page (connected)',
            builder: (context) => FutureBuilder<List<MassOutbreakInformation>>(
                future: Future(() {
                  MOSearchServiceStub.delay = Duration.zero;
                })
                    .then((value) => GetIt.I.get<MassOutbreakSearcherService>().gatherOutbreakInformation())
                    .whenComplete(() => MOSearchServiceStub.delay = const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(
                        value: MassOutbreakSearchData()..moInfo = snapshot.data,
                      ),
                      ChangeNotifierProvider.value(value: PokedexStore.provide()),
                    ],
                    child: const MOConnectAndSearchPage(),
                  );
                }),
          ),
          Story(
            name: 'MO/Search Summary Page',
            builder: (context) {
              return MOSearchResultsSummaryPage(results: [
                MassOutbreakResult(235324345, [1, 2, 4, 0, 0, 3], randomPokedexEntry()),
                MassOutbreakResult(8792464644, [1, 2, 4, 0, 0, 3, 1, 2, 4, 0, 0, 3, 1, 2, 4, 0, 0, 3], randomPokedexEntry()),
              ]);
            },
          ),
          Story(
            name: 'MO/Search Result Spawns Page',
            builder: (context) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: PokedexStore.provide()),
                ],
                child: MOSearchResultSpawnsPage(
                  result: MassOutbreakResult(235324345, [1, 2, 4, 0, 0, 3], randomPokedexEntry()),
                ),
              );
            },
          ),
          Story(
            name: 'MMO/Initial Page',
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: MassiveMassOutbreakSearchData(),
                ),
              ],
              child: const MMOConnectAndSearchPage(),
            ),
          ),
          Story(
            name: 'MMO/Initial Page (connected)',
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) {
                    var data = MassiveMassOutbreakSearchData();
                    GetIt.I.get<MMOSearchService>().gatherOutbreakInformation().then((value) => data.mmoInfo = value);
                    return data;
                  },
                ),
                ChangeNotifierProvider.value(value: PokedexStore.provide()),
              ],
              child: const MMOConnectAndSearchPage(),
            ),
          ),
          Story(
            name: 'MMO/Result Summary Page',
            builder: (context) => FutureBuilder<List<MMOSearchResults>>(
              future: MMOSearchService.provide().gatherOutbreakInformation().then((mmoInfo) {
                var data = MassiveMassOutbreakSearchData();
                data.mmoInfo = mmoInfo;
                return MMOSearchService.provide().performSearch(data).catchError((error) => print(error));
              }),
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
              future: MMOSearchService.provide().gatherOutbreakInformation().then((mmoInfo) {
                var data = MassiveMassOutbreakSearchData();
                data.mmoInfo = mmoInfo;
                return MMOSearchService.provide().performSearch(data);
              }).then((value) => value[0]),
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
                      encounterSlotsMap["64064A0B10810230"]!,
                      encounterSlotsMap["D3FB11A4B88400FC"]!,
                    ),
                    alphaRequired: false,
                    shinyRequired: true)!),
          ),
          Story(
            name: "Pokedex/Pokemon",
            builder: (context) => ListView(
              shrinkWrap: true,
              children: [
                PokedexEntrySummary(pokedexEntry: randomPokedexEntry()),
                PokedexEntrySummary(pokedexEntry: randomPokedexEntry()),
                PokedexEntrySummary(pokedexEntry: randomPokedexEntry()),
              ],
            ),
          ),
          Story(name: "Pokedex/Page", builder: (context) => const PokedexPage()),
          Story(
            name: "Alpha Logo",
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...[200, 100, 50, 25, 15, 10]
                    .map(
                      (size) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.toDouble(),
                          height: size.toDouble(),
                          // color: Colors.black,
                          child: CustomPaint(painter: AlphaLogoPainter()),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
          Story(
            name: "Shiny Logo",
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...[200, 100, 50, 25, 15, 10]
                    .map(
                      (size) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.toDouble(),
                          height: size.toDouble(),
                          // color: Colors.black,
                          child: CustomPaint(painter: ShinyLogoPainter()),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
          Story(
            name: "Pokemon Sprite",
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PokemonSprite(
                  dexNumber: randomPokedexEntry().nationalDexNumber,
                ),
                PokemonSprite(
                  dexNumber: randomPokedexEntry().nationalDexNumber,
                  shiny: true,
                ),
                PokemonSprite(
                  dexNumber: randomPokedexEntry().nationalDexNumber,
                  alpha: true,
                ),
                PokemonSprite(
                  dexNumber: randomPokedexEntry().nationalDexNumber,
                  shiny: true,
                  alpha: true,
                ),
              ],
            ),
          ),
        ],
      );

  PokedexEntry randomPokedexEntry() {
    return pokedex.values.toList()[Random().nextInt(pokedex.values.length - 1) + 1];
  }
}
