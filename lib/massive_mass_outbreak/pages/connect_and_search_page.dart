import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/search_filters.dart';
import 'package:mmo_searcher/massive_mass_outbreak/state/massive_mass_outbreak_state.dart';
import 'package:mmo_searcher/pokedex/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class ConnectAndSearchPage extends StatelessWidget {
  const ConnectAndSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<MassiveMassOutbreakData>(
        builder: (context, value, child) {
          var outbreaks = value.mmoInfo;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SearchFilters(
                shiny: value.shiny,
                alpha: value.alpha,
                multimatch: value.multimatch,
                onChange: (shiny, alpha, multimatch) {
                  value.shiny = shiny;
                  value.alpha = alpha;
                  value.multimatch = multimatch;
                },
              ),
              ...([
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: () {}, child: Text("Connect")),
                      ),
                    ),
                  ],
                )
              ].where((element) => outbreaks.isEmpty)),
              PokemonList(
                  entries: outbreaks
                      .expand((element) => element.initialRoundEncouterTable.slots + (element.bonusRoundEncouterTable?.slots ?? []))
                      .map((e) => e.pkmn)
                      .toSet()
                      .toList()
                    ..sort(
                      (a, b) => a.nationalDexNumber.compareTo(b.nationalDexNumber),
                    ),
                  shrinkWrap: true),
              ...([
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: () {}, child: Text("Search")),
                    ),
                  ],
                )
              ].where((element) => outbreaks.isNotEmpty)),
            ]),
          );
        },
      ),
    );
  }
}
