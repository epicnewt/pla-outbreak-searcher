import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';

class PokemonList extends StatelessWidget {
  final List<PokedexEntry> entries;
  final bool shrinkWrap;

  const PokemonList({Key? key, required this.entries, this.shrinkWrap = false}) : super(key: key); 
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
    return FutureBuilder<PokedexStore>(
        key: const Key("futureBuilder"),
        future: PokedexStore.load(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return StatefulBuilder(
            builder: (context, setState) {
              var shinyCharm = snapshot.data?.shinyCharm ?? false;
              return Column(
                // shrinkWrap: shrinkWrap,
                children: entries.map((e) {
                  return PokedexEntrySummary(
                    pokedexEntry: e,
                    caught: snapshot.data?.pokedexCaught[e.pokemon] ?? false,
                    complete: snapshot.data?.pokedexCompletion[e.pokemon] ?? false,
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
        });
  }
}