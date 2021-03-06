import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokedexStore extends ChangeNotifier {
  Map<String, bool> pokedexCaught;
  Map<String, bool> pokedexCompletion;
  Map<String, bool> pokedexPerfection;
  bool shinyCharm;
  dynamic _dirty;

  PokedexStore(this.pokedexCaught, this.pokedexCompletion, this.pokedexPerfection, this.shinyCharm);

  T notify<T>(T Function() fn) {
    var result = fn;
    notifyListeners();
    _queueSave();
    return result();
  }

  int select(String pokemon) {
    var change = pokedexCompletion[pokemon] == true ? 8 : 0;
    change |= pokedexPerfection[pokemon] == true ? 4 : 0;
    change |= pokedexCaught[pokemon] == true ? 2 : 0;
    change |= shinyCharm == true ? 0x1 : 0;
    return change;
  }

  bool toggleCompletion(String pokemon) => notify(() {
    return pokedexCompletion.update(pokemon, (value) => !value, ifAbsent: () => true);
  });

  bool togglePerfection(String pokemon) => notify(() {
    return pokedexPerfection.update(pokemon, (value) => !value, ifAbsent: () => true);
  });

  bool toggleCaught(String pokemon) => notify(() {
    return pokedexCaught.update(pokemon, (value) => !value, ifAbsent: () => true);
  });

  bool toggleShinyCharm() => notify(() {
    return shinyCharm = !shinyCharm;
  });

  void _queueSave() async {
    _dirty ??= Future.delayed(
      const Duration(milliseconds: 100),
      () {
        try {
          _save();
        } finally {
          _dirty = null;
        }
      },
    );
  }

  static PokedexStore load() {
    var sharedPreferences = GetIt.I.get<SharedPreferences>();
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

  _save() {
    var sharedPreferences = GetIt.I.get<SharedPreferences>();
    sharedPreferences.setString("pokedex_completion", jsonEncode(pokedexCompletion));
    sharedPreferences.setString("pokedex_perfection", jsonEncode(pokedexPerfection));
    sharedPreferences.setString("pokedex_caught", jsonEncode(pokedexCaught));
    sharedPreferences.setBool("pokedex_shiny_charm", shinyCharm);
  }

  static int getRolls(String pokemon) {
    var store = GetIt.I.get<PokedexStore>();
    var perfect = store.pokedexPerfection[pokemon] ?? false;
    var complete = (store.pokedexCompletion[pokemon] ?? false) || perfect || store.shinyCharm;
    return [
      complete,
      perfect,
      store.shinyCharm,
    ].mapIndexed((index, element) => (element) ? index + 1 : 0).sum;
  }

  static Future register() async {
    WidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerSingleton(await SharedPreferences.getInstance());
    GetIt.I.registerSingleton(PokedexStore.load());
  }

  static PokedexStore provide() {
    return GetIt.I.get();
  }
}
