import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/search_filters.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_search_service.dart';
import 'package:mmo_searcher/massive_mass_outbreak/state/massive_mass_outbreak_state.dart';
import 'package:mmo_searcher/pokedex/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class ConnectAndSearchPage extends StatelessWidget {
  const ConnectAndSearchPage({Key? key}) : super(key: key);

  void connect(context) async {
    MassiveMassOutbreakData.provide(context).mmoInfo = await MMOSearchService.provide().gatherOutbreakInformation();
  }

  void search(context) async {
    await MMOSearchService.provide().performSearch(MassiveMassOutbreakData.provide(context).mmoInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<MassiveMassOutbreakData>(
        builder: (context, mmoData, child) {
          var outbreaks = mmoData.mmoInfo;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SearchFilters(
                shiny: mmoData.shiny,
                alpha: mmoData.alpha,
                multimatch: mmoData.multimatch,
                onChange: (shiny, alpha, multimatch) {
                  mmoData.shiny = shiny;
                  mmoData.alpha = alpha;
                  mmoData.multimatch = multimatch;
                },
              ),
              ...([
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => connect(context),
                          child: const Text("Connect"),
                        ),
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
                      child: ElevatedButton(onPressed: () => search(context), child: const Text("Search")),
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
