import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/pokemon_sprite.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class SearchResultSummary extends StatelessWidget {
  final String groupSeed;
  final PokedexEntry pkmn;
  final List<PathSpawnInfo> paths;

  const SearchResultSummary({Key? key, required this.pkmn, required this.paths, this.groupSeed = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    ...paths.map((e) => Hero(tag: groupSeed + e.mmoPath.toString(), child: Text(e.mmoPath.toString())))
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
