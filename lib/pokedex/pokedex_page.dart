import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';

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
      body: FutureBuilder<PokedexStore>(
          key: const Key("futureBuilder"),
          future: PokedexStore.load(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return StatefulBuilder(
              builder: (context, setState) {
                var shinyCharm = snapshot.data?.shinyCharm ?? false;
                return ListView(
                  children: entries.map((e) {
                    return PokedexEntrySummary(
                      pokedexEntry: e,
                      caught: snapshot.data?.pokedexCaught[e.pokemon] ?? false,
                      complete: shinyCharm || (snapshot.data?.pokedexCompletion[e.pokemon] ?? false),
                      perfect: snapshot.data?.pokedexPerfection[e.pokemon] ?? false,
                      shinyCharm: shinyCharm,
                      onChange: (index) {
                        setState(() {
                          onPokedexEntryChange(index, e.pokemon, snapshot.data!);
                        });
                      },
                    );
                  }).toList(),
                );
              },
            );
          }),
    );
  }
}
