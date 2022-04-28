import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PokedexStore {
  Map<String, bool> pokedexCaught;
  Map<String, bool> pokedexCompletion;
  Map<String, bool> pokedexPerfection;
  bool shinyCharm;

  PokedexStore(this.pokedexCaught, this.pokedexCompletion, this.pokedexPerfection, this.shinyCharm);

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

  static Future<PokedexStore> load() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> completion = jsonDecode(sharedPreferences.getString("pokedex_completion") ?? '{}');
    Map<String, dynamic> perfection = jsonDecode(sharedPreferences.getString("pokedex_perfection") ?? '{}');
    Map<String, dynamic> caught = jsonDecode(sharedPreferences.getString("pokedex_caught") ?? '{}');
    bool shinyCharm = sharedPreferences.getBool("pokedex_shiny_charm") ?? false;

    return PokedexStore(
      (caught.map((key, value) => MapEntry(key, value == true))),
      (completion.map((key, value) => MapEntry(key, value == true))),
      (perfection.map((key, value) => MapEntry(key, value == true))),
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