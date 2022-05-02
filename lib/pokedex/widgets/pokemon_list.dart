import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';

class PokemonList extends StatelessWidget {
  final List<PokedexEntry> entries;
  final bool shrinkWrap;

  const PokemonList({Key? key, required this.entries, this.shrinkWrap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokedexStore>(
        key: const Key("futureBuilder"),
        future: Future.value(PokedexStore.load()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Column(
            children: entries.map((e) => PokedexEntrySummary(pokedexEntry: e)).toList(),
          );
        });
  }
}
