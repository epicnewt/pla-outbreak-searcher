import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/pokemon_sprite.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';

class SearchResultDetails extends StatelessWidget {
  final String groupSeed;
  final PathSpawnInfo match;

  const SearchResultDetails({Key? key, required this.match, this.groupSeed = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Hero(
              tag: match.mmoPath.toString(),
              child: Text(
                match.mmoPath.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24 - 8),
              ),
            ),
          ),
          ...match.matches
              .map((spawn) => Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PokemonSprite(
                        dexNumber: spawn.pkmn.nationalDexNumber,
                        form: spawn.form,
                        shiny: spawn.shiny,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                spawn.pkmn.pokemon,
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 24 - 8),
                              ),
                            ),
                            Text('${spawn.gender} ${spawn.evs} ${spawn.nature}')
                            // ...matches.map((path) => Text(path.toString())),
                          ],
                        ),
                      ),
                    ],
                  ))
              .toList()
        ],
      ),
    );
  }
}
