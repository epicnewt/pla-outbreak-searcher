import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/pokemon_sprite.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/search_result_details.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';

class MMOSearchResultDetailsPage extends StatelessWidget {
  final MMOSearchResults searchResults;

  const MMOSearchResultDetailsPage({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PokemonSprite(dexNumber: searchResults.mmo.initialRoundEncouterTable.slots.first.pkmn.nationalDexNumber),
            Text(searchResults.mmo.initialRoundEncouterTable.slots.first.pkmn.pokemon),
          ],
        ),
      ),
      body: ListView(children: searchResults.paths.map((e) => SearchResultDetails(match: e)).toList()),
    );
  }
}
