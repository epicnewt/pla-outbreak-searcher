import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/widgets/pokedex_entry_summary.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<PokedexEntry> entries = pokedex.entries //
    .where((MapEntry<int, PokedexEntry> e) => e.key > 0) //
    .map((e) => e.value) //
    .toList();

List<PokedexEntry> entriesByDexNumber = entries..sort((a, b) => a.nationalDexNumber.compareTo(b.nationalDexNumber));

class PokedexState {
  Map<String, bool> pokedexCaught;
  Map<String, bool> pokedexCompletion;
  Map<String, bool> pokedexPerfection;
  bool shinyCharm;

  PokedexState(this.pokedexCaught, this.pokedexCompletion, this.pokedexPerfection, this.shinyCharm);

  void toggleCompletion(String pokemon) {
    pokedexCompletion.update(pokemon, (value) => !value, ifAbsent: () => true);
  }

  void togglePerfection(String pokemon) {
    pokedexPerfection.update(pokemon, (value) => !value, ifAbsent: () => true);
  }

  void toggleCaught(String pokemon) {
    pokedexCaught.update(pokemon, (value) => !value, ifAbsent: () => true);
  }

  void toggleShinyCharm() {
    shinyCharm = !shinyCharm;
  }

  static Future<PokedexState> load() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> completion = jsonDecode(sharedPreferences.getString("pokedex_completion") ?? '{}');
    Map<String, dynamic> perfection = jsonDecode(sharedPreferences.getString("pokedex_perfection") ?? '{}');
    Map<String, dynamic> caught = jsonDecode(sharedPreferences.getString("pokedex_caught") ?? '{}');
    bool shinyCharm = sharedPreferences.getBool("pokedex_shiny_charm") ?? false;

    return PokedexState(
      HashMap()..addAll(caught.map((key, value) => MapEntry(key, value == true))),
      HashMap()..addAll(completion.map((key, value) => MapEntry(key, value == true))),
      HashMap()..addAll(perfection.map((key, value) => MapEntry(key, value == true))),
      shinyCharm,
    );
  }

  save() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("pokedex_completion", jsonEncode(pokedexCompletion));
    sharedPreferences.setString("pokedex_perfection", jsonEncode(pokedexPerfection));
    sharedPreferences.setString("pokedex_caught", jsonEncode(pokedexCaught));
    sharedPreferences.setBool("pokedex_shiny_charm", shinyCharm);
  }
}


class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  onPokedexEntryChange(int action, String pokemon, PokedexState state) {
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
      body: FutureBuilder<PokedexState>(
          key: const Key("futureBuilder"),
          future: PokedexState.load(),
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
