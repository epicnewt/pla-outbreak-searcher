import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/spawn.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/pokemon_sprite.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';

class Tuple2<F, S> {
  final F first;
  final S second;

  Tuple2(this.first, this.second);
  copy({F? first, S? second}) => Tuple2(first ?? this.first, second ?? this.second);
}

class SpawnDetails extends StatelessWidget {
  final Spawn spawn;

  const SpawnDetails({Key? key, required Spawn this.spawn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checked = false;
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: StatefulBuilder(builder: (context, setState) {
              return GestureDetector(
                onTap: () => setState(() { checked = !checked; }),
                child: PokemonSprite(
                  dexNumber: spawn.pkmn.nationalDexNumber,
                  form: spawn.form,
                  shiny: spawn.shiny,
                  alpha: spawn.alpha,
                  checked: checked,
                ),
              );
            }),
          ),
          ...(spawn.gender == "M" ? [const FaIcon(FontAwesomeIcons.mars, size: 18)] : []),
          ...(spawn.gender == "F" ? [const FaIcon(FontAwesomeIcons.venus, size: 18)] : []),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "${spawn.evs} ${spawn.nature}",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResultsSpawnsPage extends StatelessWidget {
  final PathSpawnInfo match;

  const SearchResultsSpawnsPage({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(match.pokemon.map(((e) => e.length)));
    return Scaffold(
      appBar: AppBar(
        title: Text(match.mmoPath.toString()),
      ),
      body: ListView(
        children: match.summary
            .expand(
              (e) => [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(pathDescrition(e.first, e.second)),
                  ),
                  color: Colors.grey[200],
                ),
                ...e.third.map((spawn) => SpawnDetails(spawn: spawn)),
              ],
            )
            .toList(),
      ),
    );
  }
}

String pathDescrition(String pathType, int action) {
  if (action == 0) {
    return "Initial Spawns" + ((pathType == "B") ? " of Bonus Round" : "");
  } else if (pathType == "R") {
    return "Leave $action, then go back to camp";
  }

  return "Despawn $action pokemon";
}
