import 'package:mmo_searcher/mass_outbreak/search/rng/spawn.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';

import 'package:collection/collection.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';

var _mainRng = XOROSHIROLite();
var _spawnerRng = XOROSHIROLite();

class PathSpawnInfo {
  final List<List<List<int>>> seedsOfSpawnGroups;
  final int rolls;
  final int revisitsPathStart;
  final int bonusPathStart;
  final EncounterTable initialTable;
  final EncounterTable? bonusTable;
  final MMOPath mmoPath;
  bool Function(Spawn) _filter;
  late final List<List<Spawn>> pokemon = _generatePokemon();
  late final List<Spawn> matches = pokemon.expand((list) => list.where(_filter).toList()).toList();

  PathSpawnInfo(
    this.seedsOfSpawnGroups,
    this.rolls,
    this.revisitsPathStart,
    this.bonusPathStart,
    this.initialTable,
    this.bonusTable,
    this.mmoPath,
    this._filter
  );

  void wrapFilter(bool Function(Spawn) filter) {
    var parent = _filter;
    _filter = (spawn) => parent(spawn) && filter(spawn);
  }

  List<List<Spawn>> _generatePokemon() {
    return seedsOfSpawnGroups.mapIndexed((i, group) => group.map((seed) => _fromSeed(seed, i > bonusPathStart)).toList()).toList();
  }

  Spawn _fromSeed(List<int> seed, bool isBonusSpawn) {
    _mainRng.reseed(seed.first, s1: seed.last);
    var encounterTable = isBonusSpawn ? bonusTable ?? initialTable : initialTable;
    return generateSpawnLite(_mainRng, _spawnerRng, false, null, rolls, encounterTable: encounterTable)!;
  }
}