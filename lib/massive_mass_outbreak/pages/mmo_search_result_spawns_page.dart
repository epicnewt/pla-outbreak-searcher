import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/spawn.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:provider/provider.dart';

class Tuple2<F, S> {
  final F first;
  final S second;

  Tuple2(this.first, this.second);
  copy({F? first, S? second}) => Tuple2(first ?? this.first, second ?? this.second);
}

class MMOSearchResultSpawnsPage extends StatelessWidget {
  final PathSpawnInfo match;

  const MMOSearchResultSpawnsPage({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(match.mmoPath.toString()),
      ),
      body: Consumer<PokedexStore>(builder: (context, value, child) {
        return Column(
          children: [
            ...match.pokemon.expand((element) => element).map((e) => e.pkmn).toSet().dexOrder().map((e) => PokedexEntrySummary(pokedexEntry: e)),
            Expanded(
              child: ListView(
                  children: match.summary
                      .expand(
                        (e) => [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(pathDescrition(e.first, e.second)),
                            ),
                            color: Colors.grey[200],
                          ),
                          ...e.third.map((spawn) => SpawnDetails(spawn: spawn, isRevisit: e.first == "R")),
                        ],
                      )
                      .toList(),
                ),
            ),
          ],
        );
      }),
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
