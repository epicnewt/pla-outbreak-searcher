import 'package:flutter/material.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:collection/collection.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/spawn.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:provider/provider.dart';

class MOSearchResultSpawnsPage extends StatelessWidget {
  final MassOutbreakResult result;

  const MOSearchResultSpawnsPage({Key? key, required this.result}) : super(key: key);

  pathDescription(List<int> action, bool isFirst) {
    switch (action.first) {
      case 4:
        return isFirst ? "Intial Spawns" : "Return to town";
      default:
        return "Catch ${action.first}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result.path.join(",")),
      ),
      body: Column(
        children: [
          PokedexEntrySummary(pokedexEntry: result.pokemon),
          Expanded(
            child: Consumer<PokedexStore>(
              builder: (context, value, child) {
                return ListView(
                  children: [
                    ...result.advances().expandIndexed((i, advance) {
                      return [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(pathDescription([4], i == 0)),
                          ),
                          color: Colors.grey[200],
                        ),
                        ...advance.reseeds.first.spawns.map((spawn) => SpawnDetails(spawn: spawn)),
                        if (advance.reseeds.length > 1)
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(pathDescription(advance.actions, false)),
                            ),
                            color: Colors.grey[200],
                          ),
                        ...advance.reseeds.skip(1).expand(
                              (reseed) => reseed.spawns.map((spawn) => SpawnDetails(spawn: spawn)).toList(),
                            ),
                      ];
                    })
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
