import 'package:flutter/material.dart';
import 'package:mmo_searcher/common/connection/switch_connection_exception.dart';
import 'package:mmo_searcher/common/widgets/app_drawer.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/search_filters.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_search_service.dart';
import 'package:mmo_searcher/massive_mass_outbreak/state/massive_mass_outbreak_state.dart';
import 'package:mmo_searcher/navigator.dart';
import 'package:mmo_searcher/pokedex/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class MMOConnectAndSearchPage extends StatelessWidget {
  const MMOConnectAndSearchPage({Key? key}) : super(key: key);

  void connect(context) async {
    try {
      MassiveMassOutbreakSearchData.provide(context).mmoInfo = await MMOSearchService.provide().gatherOutbreakInformation();
    } on SwitchConnectionException catch (sce) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              sce.availableAddresses.isEmpty
                  ? const Text("Switch is not available.")
                  : const Flexible(child: Text("Connot find Switch. There are multiple hosts with serices running on port 6000.")),
            ],
          ),
        ),
      );
    }
    return;
  }

  void search(context) async {
    print("Searching");
    var results = await MMOSearchService.provide().performSearch(MassiveMassOutbreakSearchData.provide(context));
    AppRouteNavigator.provide().toMMOSearchResults(context, results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MMO Searcher"),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Consumer<MassiveMassOutbreakSearchData>(
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
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => connect(context),
                        child: outbreaks.isEmpty ? const Text("Connect") : const Text("Reconnect"),
                      ),
                    ),
                  ],
                ),
                PokemonList(
                  shrinkWrap: true,
                  entries: outbreaks
                      .expand((element) => element.initialRoundEncouterTable.slots + (element.bonusRoundEncouterTable?.slots ?? []))
                      .map((e) => e.pkmn)
                      .toSet()
                      .toList()
                    ..sort(
                      (a, b) => a.nationalDexNumber.compareTo(b.nationalDexNumber),
                    ),
                ),
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
      ),
    );
  }
}
