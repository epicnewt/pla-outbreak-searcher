
import 'package:mmo_searcher/mass_outbreak/search/rng/spawn.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

final XOROSHIROLite _mainRng = XOROSHIROLite();
final XOROSHIROLite _spawnerRng = XOROSHIROLite();

int determineBonusSeed(int groupSeed, MMOPath path) {
  _mainRng.reseed(groupSeed);
  _mainRng.advanceAndReseed(4); // initial spawns
  for (var action in path.initialPath) {
    _mainRng.advanceAndReseed(action);
  }
  for (int remaining in path.revisit) {
    _mainRng.advanceAndReseed(4 - remaining);
  }
  return _mainRng.current;
}

/// Generate the final spawns of a path that can be used to filter for a matching path.
/// Non alpha and non shiny spawns are not returned if they are required. This makes the
/// filtering more efficient by greatly reducing the RNG rolls, esspecially when an alpha
/// is required. 
List<Spawn> generateSpawnsOfPath(MMOPath mmoPath, MMOInfo info, int rolls, {required bool alphaRequired, required bool shinyRequired}) {
  var groupSeed = mmoPath.bonusPath.isEmpty ? info.groupSeed : determineBonusSeed(info.groupSeed, mmoPath);
  var encounterTable = mmoPath.bonusPath.isEmpty ? info.initialRoundEncouterTable : info.bonusRoundEncouterTable!;
  _mainRng.reseed(groupSeed);

  List<int> path = mmoPath.bonusPath.isEmpty ? (mmoPath.initialPath + mmoPath.revisit.map((remaining) => 4 - remaining).toList()) : mmoPath.bonusPath;

  _mainRng.advanceAndReseed(4); // initial spawns

  for (var i = 0; i < path.length - 1; i++) {
    _mainRng.advanceAndReseed(path[i]);
  }

  List<Spawn> list = [];

  var count = path.isEmpty ? 4 : path.last;
  for (var i = 0; i < count; i++) {
    //TODO used encounter slot to determine PkMn
    //alphaSpawn is always false as multiple alphas can spawn at once in MMOs
    Spawn? spawn = generateSpawnLite(_mainRng, _spawnerRng, false, null, rolls, alphaRequired: alphaRequired, shinyRequired: shinyRequired, encounterTable: encounterTable);
    if (spawn != null && spawn != Spawn.DUMMY_ALPHA) {
      list.add(spawn);
    }
  }

  return list;
}