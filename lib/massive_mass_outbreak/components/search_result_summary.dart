import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/pokemon_sprite.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/navigator.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class SearchResultSummary extends StatelessWidget {
  final MMOSearchResults results;

  const SearchResultSummary({Key? key, required this.results}) : super(key: key);

  PokedexEntry get pkmn => results.mmo.initialRoundEncouterTable.slots.first.pkmn;
  List<PathSpawnInfo> get paths => results.paths;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (paths.length == 1) {
          AppRouteNavigator.provide().toMMOSearchResultSpawns(context, paths.first);
        } else {
          AppRouteNavigator.provide().toMMOSearchResultDetails(context, results);
        }
      },
      child: Card(
        child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PokemonSprite(dexNumber: pkmn.nationalDexNumber),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          pkmn.pokemon,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24 - 8),
                        ),
                      ),
                      ...paths.map((e) => Text(e.mmoPath.toString()))
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
