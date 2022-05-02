import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/widgets/pokemon_list.dart';

List<PokedexEntry> entries = pokedex.entries //
    .where((MapEntry<int, PokedexEntry> e) => e.key > 0) //
    .map((e) => e.value) //
    .toList();

List<PokedexEntry> entriesByDexNumber = entries..sort((a, b) => a.nationalDexNumber.compareTo(b.nationalDexNumber));

class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: SingleChildScrollView(child: PokemonList(entries: entries)),
    );
  }
}
