import 'package:mmo_searcher/common/rng/spawn.dart';
import 'package:mmo_searcher/common/rng/xoroshiro.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';

import 'package:collection/collection.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';

var _mainRng = XOROSHIROLite();
var _spawnerRng = XOROSHIROLite();

class Tuple3<F, S, T> {
  final F first;
  final S second;
  final T third;

  Tuple3(this.first, this.second, this.third);
  copy({F? first, S? second, T? third}) => Tuple3(first ?? this.first, second ?? this.second, third ?? this.third);

  @override
  String toString() {
    return "($first, $second, $third)";
  }
}

class PathSpawnInfo {
  final List<List<List<int>>> seedsOfSpawnGroups;
  final int revisitsPathStart;
  final int bonusPathStart;
  final EncounterTable initialTable;
  final EncounterTable? bonusTable;
  final MMOPath mmoPath;
  bool Function(Spawn) _filter;
  String _rolls = "";
  List<List<Spawn>> _pokemon = [];
  List<Spawn> _matches = [];
  late final entries = pokemon.expand((element) => element).map((e) => e.pkmn).toSet().dexOrder();

  bool _hasRollsChanged() {
    var rolls = (initialTable.slots + (bonusTable?.slots ?? [])).map((e) => e.pkmn).dexOrder().map((e) => PokedexStore.getRolls(e.pokemon)).join("|");
    if (_rolls != rolls) {
      _rolls = rolls;
      return true;
    }
    return false;
  }

  List<List<Spawn>> get pokemon {
    if (_hasRollsChanged()) {
      _pokemon = _generatePokemon();
      _matches = _generateMacthes();
    }
    return _pokemon;
  }

  List<Spawn> get matches {
    if (_hasRollsChanged()) {
      _pokemon = _generatePokemon();
      _matches = _generateMacthes();
    }
    return _matches;
  }

  List<Tuple3<String, int, List<Spawn>>> get summary => (List.generate(
        mmoPath.initialPath.length + 1,
        (index) => (index == 0 //
                ? Tuple3("I", 0, pokemon[index]) //
                : Tuple3("I", mmoPath.initialPath[index - 1], pokemon[index]) //
            ),
      ) +
      List.generate(
        mmoPath.revisit.length,
        (index) => Tuple3("R", mmoPath.revisit[index], pokemon[index + mmoPath.initialPath.length + 1]),
      ) +
      List.generate(
        (mmoPath.bonusPath.isEmpty) ? 0 : mmoPath.bonusPath.length + 1,
        (index) => (index == 0 //
                ? Tuple3("B", 0, pokemon[index + mmoPath.initialPath.length + mmoPath.revisit.length + 1]) //
                : Tuple3("B", mmoPath.bonusPath[index - 1], pokemon[index + mmoPath.initialPath.length + mmoPath.revisit.length + 1]) //
            ),
      ));

  PathSpawnInfo(
    this.seedsOfSpawnGroups,
    this.revisitsPathStart,
    this.bonusPathStart,
    this.initialTable,
    this.bonusTable,
    this.mmoPath,
    this._filter,
  );

  void wrapFilter(bool Function(Spawn) filter) {
    var parent = _filter;
    _filter = (spawn) => parent(spawn) && filter(spawn);
  }

  List<List<Spawn>> _generatePokemon() {
    return seedsOfSpawnGroups.mapIndexed((i, group) => group.map((seed) => _fromSeed(seed, i > bonusPathStart)).toList()).toList();
  }

  List<Spawn> _generateMacthes() {
    return _pokemon // remove ghost pokemon
      .whereIndexed(_isNotGhostSpawnGroup) //
      .expand((list) => list.where(_filter).toList())
      .toList();
  }

  bool _isNotGhostSpawnGroup(int index, dynamic _) =>
      index < (mmoPath.initialPath.length) || index > (mmoPath.initialPath.length + mmoPath.revisit.length);

  Spawn _fromSeed(List<int> seed, bool isBonusSpawn) {
    _mainRng.reseed(seed.first, s1: seed.last);
    var encounterTable = isBonusSpawn ? (bonusTable ?? initialTable) : initialTable;
    var spawn = generateSpawnLite(
      _mainRng,
      _spawnerRng,
      false,
      null,
      encounterTable: encounterTable,
      outbreakType: OutbreakType.massiveMassOutbreak,
    );
    return spawn!;
  }
}
