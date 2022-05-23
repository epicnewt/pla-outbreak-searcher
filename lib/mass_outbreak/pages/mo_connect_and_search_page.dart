import 'package:flutter/material.dart';
import 'package:mmo_searcher/common/connection/switch_connection_exception.dart';
import 'package:mmo_searcher/common/debug.dart';
import 'package:mmo_searcher/common/feature_switches.dart';
import 'package:mmo_searcher/common/widgets/app_drawer.dart';
import 'package:mmo_searcher/common/widgets/connect_action.dart';
import 'package:mmo_searcher/common/widgets/search_button.dart';
import 'package:mmo_searcher/mass_outbreak/pages/widgets/mo_search_filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/navigator.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:provider/provider.dart';

class MOConnectAndSearchPage extends StatelessWidget {
  const MOConnectAndSearchPage({Key? key}) : super(key: key);

  Future<dynamic> connect(context) async {
    try {
      MassOutbreakSearchData.provide(context).moInfo = await MassOutbreakSearcherService.provide().gatherOutbreakInformation();
    } on SwitchConnectionException catch (sce) {
      debug("Switch connection error: ${sce.availableAddresses}");
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

  Future search(BuildContext context) async {
    var result = await MassOutbreakSearcherService.provide().performSearch(MassOutbreakSearchData.provide(context));
    debug(result);
    var matches = result.whereType<MassOutbreakResult>().toList();
    if (matches.isNotEmpty) {
      AppRouteNavigator.provide().toMOSearchResults(context, matches);
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = false;

    return Scaffold(
      appBar: AppBar(title: const Text("Mass Outbreak Searcher"), actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ConnectAction(
            onPress: () => connect(context),
          ),
        ),
      ]),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Consumer<MassOutbreakSearchData>(
              builder: (context, value, child) {
                return MOSearchFilters(
                  onChange: (shiny, alpha, male, female, multimatch) {
                    value.update(shiny, alpha, male, female, multimatch);
                  },
                  shiny: value.shiny,
                  alpha: value.alpha,
                  male: value.male,
                  female: value.female,
                  multimatch: value.multimatch,
                );
              },
            ),
            Selector<MassOutbreakSearchData, List<MassOutbreakInformation>?>(
              selector: (_, data) => data.moInfo,
              builder: (context, moInfo, child) {
                if (moInfo != null) {
                  return ListView(
                    shrinkWrap: true,
                    children: moInfo.map<Widget>(
                      (moInfo) {
                        return PokedexEntrySummary(
                          pokedexEntry: pokedex[moInfo.species]!,
                          subHeading: Text("Seed: 0x${moInfo.seed.toUpperCase()}\nSpawns: ${moInfo.spawns}"),
                        );
                      },
                    ).toList()
                      ..add(
                        SearchButton(onPressed: () => search(context)),
                      ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ]),
        ),
      ),
    );
  }
}
