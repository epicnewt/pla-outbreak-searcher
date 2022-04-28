import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokemon_list.dart';

List<PokedexEntry> entries = pokedex.entries //
    .where((MapEntry<int, PokedexEntry> e) => e.key > 0) //
    .map((e) => e.value) //
    .toList();

List<PokedexEntry> entriesByDexNumber = entries..sort((a, b) => a.nationalDexNumber.compareTo(b.nationalDexNumber));

class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  onPokedexEntryChange(int action, String pokemon, PokedexStore state) {
    if (action == 0) {
      state.toggleCompletion(pokemon);
    } else if (action == 1) {
      state.togglePerfection(pokemon);
    } else if (action == 2) {
      state.toggleShinyCharm();
    } else if (action == 3) {
      state.toggleCaught(pokemon);
    }
    state.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: SingleChildScrollView(child: PokemonList(entries: entries)),
    );
  }
}
