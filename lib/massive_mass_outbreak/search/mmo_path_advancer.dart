import 'package:mmo_searcher/mass_outbreak/search/rng/spawn.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';

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
PathSpawnInfo? generateSpawnsOfPath(MMOPath mmoPath, MMOInfo info, int rolls, {required bool alphaRequired, required bool shinyRequired}) {
  // var groupSeed = mmoPath.bonusPath.isEmpty ? info.groupSeed : determineBonusSeed(info.groupSeed, mmoPath);
  var groupSeed = info.groupSeed;
  var encounterTable = mmoPath.bonusPath.isEmpty ? info.initialRoundEncouterTable : info.bonusRoundEncouterTable!;
  _mainRng.reseed(groupSeed);

  List<List<List<int>>> seedGroups = [];

  // List<int> path = mmoPath.bonusPath.isEmpty ? (mmoPath.initialPath + mmoPath.revisit.map((remaining) => 4 - remaining).toList()) : mmoPath.bonusPath;
  List<int> path = (mmoPath.initialPath + mmoPath.revisit.map((remaining) => 4 - remaining).toList());

  if (mmoPath.bonusPath.isNotEmpty) {
    path += [4] + mmoPath.bonusPath;
  }

  if (path.isNotEmpty) {
    List<List<int>> seeds = [];
    for (var i = 0; i < 4; i++) {
      seeds.add([_mainRng.s0, _mainRng.s1]);
      _mainRng.next();
      _mainRng.next();
    }
    _mainRng.reseedWithNext();
    seedGroups.add(seeds);
  }
  for (var i = 0; i < path.length - 1; i++) {
    List<List<int>> seeds = [];
    for (var p = 0; p < path[i]; p++) {
      seeds.add([_mainRng.s0, _mainRng.s1]);
      _mainRng.next();
      _mainRng.next();
    }
    _mainRng.reseedWithNext();
    seedGroups.add(seeds);
  }

  List<Spawn> list = [];

  var count = path.isEmpty ? 4 : path.last;
  List<List<int>> seeds = [];
  for (var i = 0; i < count; i++) {
    seeds.add([_mainRng.s0, _mainRng.s1]);
   
    //alphaSpawn is always false as multiple alphas can spawn at once in MMOs
    Spawn? spawn = generateSpawnLite(
      _mainRng,
      _spawnerRng,
      false,
      null,
      alphaRequired: alphaRequired,
      shinyRequired: shinyRequired,
      encounterTable: encounterTable,
    );
    if (spawn != null && spawn != Spawn.DUMMY_ALPHA) {
      list.add(spawn);
    }
  }
  seedGroups.add(seeds);

  if (list.isEmpty) {
    return null;
  }

  //fill in final step for seeds
  if (path.isEmpty) {
    _mainRng.reseed(groupSeed);
  } else {
    var lastSeed = seedGroups.last.first.first;
    _mainRng.reseed(lastSeed);
    _mainRng.advanceAndReseed(path.last);
  }

  return PathSpawnInfo(
    seedGroups,
    rolls,
    mmoPath.initialPath.length,
    mmoPath.initialPath.length + mmoPath.revisit.length,
    info.initialRoundEncouterTable,
    info.bonusRoundEncouterTable,
    mmoPath.copy(),
    (s) => s.alpha == alphaRequired && s.shiny == shinyRequired
  );
}

/**
 * M 100000 Careful []
 * F 002101 Bashful []
 * M 233030 Impish Alpha X
 * M 000210 Docile []
 */
