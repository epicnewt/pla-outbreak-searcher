import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/pokemon_sprite.dart';
import 'package:mmo_searcher/navigator.dart';

class MOSearchResultsSummaryPage extends StatelessWidget {
  final List<MassOutbreakResult?> results;

  const MOSearchResultsSummaryPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mass Outbreaks")),
      body: ListView(
        children: results.whereType<MassOutbreakResult>().map((result) {
          return GestureDetector(
            onTap: () {
              AppRouteNavigator.provide().toMOSearchResultSpawns(context, result);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.path.join(", "),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...result.matches.map(
                      (spawn) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: PokemonSprite(
                              dexNumber: spawn.pkmn.nationalDexNumber,
                              shiny: spawn.shiny,
                              alpha: spawn.alpha,
                            ),
                          ),
                          if (spawn.gender == "M") const FaIcon(FontAwesomeIcons.mars, size: 18),
                          if (spawn.gender == "F") const FaIcon(FontAwesomeIcons.venus, size: 18),
                          Text(" ${spawn.evs} ${spawn.nature}")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
