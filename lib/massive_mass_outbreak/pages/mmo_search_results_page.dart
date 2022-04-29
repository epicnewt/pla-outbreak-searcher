import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/search_result_summary.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';

class MMOSearchResultsPage extends StatelessWidget {
  final List<MMOSearchResults> searchResults;

  const MMOSearchResultsPage({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MMO Results"),
      ),
      body: ListView(
        children: searchResults.map((e) => SearchResultSummary(
          pkmn: e.mmo.initialRoundEncouterTable.slots[0].pkmn,
          paths: e.paths,
        )).toList(),
      ),
    );
  }
}