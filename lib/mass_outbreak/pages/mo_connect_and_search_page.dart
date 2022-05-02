import 'package:flutter/material.dart';
import 'package:mmo_searcher/common/connection/switch_connection_exception.dart';
import 'package:mmo_searcher/common/debug.dart';
import 'package:mmo_searcher/common/widgets/app_drawer.dart';
import 'package:mmo_searcher/mass_outbreak/pages/widgets/mo_search_filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:provider/provider.dart';

class MOConnectAndSearchPage extends StatelessWidget {
  const MOConnectAndSearchPage({Key? key}) : super(key: key);

  void connect(context) async {
    try {
      MassOutbreakSearchData.provide(context).moInfo = await MassOutbreakSearcher.provide().gatherOutbreakInformation();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mass Outbreak Searcher")),
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => connect(context),
                    child: Text("Connect"),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
