import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/search_result_summary.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:collection/collection.dart';

class MMOSearchResultsPage extends StatelessWidget {
  final List<MMOSearchResults> searchResults;

  const MMOSearchResultsPage({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List<Widget>> map2 = searchResults.groupListsBy<String>((element) => element.mmo.map).map((map, spawners) {
      return MapEntry(
        map,
        [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(map),
            ),
            color: Colors.grey[200],
          ),
          ...spawners.map(
            (e) => GestureDetector(
              child: MMOSearchResultSummary(
                results: e,
              ),
            ),
          )
        ],
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("MMO Results"),
      ),
      body: ListView(
        children: map2.entries.expand((element) => element.value).toList(),
      ),
    );
  }
}
