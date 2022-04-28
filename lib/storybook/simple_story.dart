import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/search_result_details.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/search_result_spawns.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/search_result_summary.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/connect_and_search_page.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_advancer.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/state/massive_mass_outbreak_state.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_page.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const StorybookApp());

PathSpawnInfo asSpawnInfo(MMOPath path) {
  return PathSpawnInfo([], 0, 0, 0, EncounterTable.massoutbreak, null, path, (p) => p.alpha && p.shiny);
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        stories: [
          // Search results map??
          // Pokemon for dex and tracker
          // Maps for pokemon results with summary
          // Pokemon for search results
          // Search results path picker
          // Path spawn details

          Story(
            name: 'MMO/Initial Page',
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                    value: MassiveMassOutbreakData()
                      ..mmoInfo = [
                        MMOInfo(
                          BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                          9,
                          7,
                          encounterSlotsMap["E680740C6BE14EFB"]!,
                          null,
                        ),
                        MMOInfo(
                          BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                          9,
                          7,
                          encounterSlotsMap["D3FB11A4B88400FC"]!,
                          encounterSlotsMap["64064A0B10810230"]!,
                        ),
                        MMOInfo(
                          BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                          9,
                          7,
                          encounterSlotsMap["C213972F6D316665"]!,
                          encounterSlotsMap["EEFEE"]!,
                        )
                      ]),
              ],
              child: ConnectAndSearchPage(),
            ),
          ),

          Story(
            name: 'MMO/Outbreak Result Summary',
            builder: (context) => ListView(
              shrinkWrap: true,
              children: [
                SearchResultSummary(
                  pkmn: randomPokedexEntry(),
                  paths: [
                    asSpawnInfo(MutableMMOPath.withPaths([1, 4, 3], [], []).readonly)
                  ],
                ),
                SearchResultSummary(
                  pkmn: randomPokedexEntry(),
                  paths: [
                    asSpawnInfo(MutableMMOPath.withPaths([1, 4, 3], [], []).readonly),
                    asSpawnInfo(MutableMMOPath.withPaths([1, 4, 3], [2], []).readonly),
                    asSpawnInfo(MutableMMOPath.withPaths([1, 4, 3], [], [2]).readonly),
                    asSpawnInfo(MutableMMOPath.withPaths([1, 2, 1, 1], [2, 1], [3]).readonly),
                    asSpawnInfo(MutableMMOPath.withPaths([1, 3, 1], [1], [2, 1]).readonly),
                  ],
                ),
              ],
            ),
          ),
          Story(
            name: 'MMO/Search Result Details',
            builder: (context) => ListView(
              shrinkWrap: true,
              children: [
                SearchResultDetails(
                  match: generateSpawnsOfPath(
                      MMOPath(MutableMMOPath.withPaths([1, 3, 1], [1], [2, 1])),
                      MMOInfo(
                        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                        9,
                        7,
                        encounterSlotsMap["41E4947058A65FD8"]!,
                        encounterSlotsMap["702EDC94E9044B34"]!,
                      ),
                      1400,
                      alphaRequired: false,
                      shinyRequired: true)!,
                ),
                SearchResultDetails(
                  match: generateSpawnsOfPath(
                      MMOPath(MutableMMOPath.withPaths([1, 2, 1, 1], [2, 1], [3])),
                      MMOInfo(
                        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                        9,
                        7,
                        encounterSlotsMap["D3FB11A4B88400FC"]!,
                        encounterSlotsMap["64064A0B10810230"]!,
                      ),
                      4000,
                      alphaRequired: false,
                      shinyRequired: true)!,
                ),
              ],
            ),
          ),
          Story(
            name: "MMO/Path Details",
            builder: (context) => SearchResultsSpawnsPage(
                match: generateSpawnsOfPath(
                    MMOPath(MutableMMOPath.withPaths([1, 2, 1, 1], [2, 1], [3])),
                    MMOInfo(
                      BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                      9,
                      7,
                      encounterSlotsMap["D3FB11A4B88400FC"]!,
                      encounterSlotsMap["64064A0B10810230"]!,
                    ),
                    4000,
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
