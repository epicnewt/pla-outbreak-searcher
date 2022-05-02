import 'dart:isolate';

import 'package:mmo_searcher/common/rng/spawn.dart';
import 'package:mmo_searcher/common/rng/xoroshiro.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/pass_path_generator.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class Advance {
  final List<int> actions;
  final List<ReseedSet> reseeds;

  Advance(this.actions, this.reseeds);
}

class ReseedSet {
  final String groupSeed;
  final List<Spawn> spawns;

  ReseedSet(this.groupSeed, this.spawns);
}

class MassOutbreakResult {
  final int seed;
  final List<int> path;
  final PokedexEntry pokemon;

  MassOutbreakResult(this.seed, this.path, this.pokemon);

  List<Advance> advances(int rolls) {
    XOROSHIROLite rng = XOROSHIROLite();
    XOROSHIROLite spawnRng = XOROSHIROLite();
    rng.reseed(seed);

    List<Advance> advances = [];
    List<int> actions = [];
    List<ReseedSet> reseeds = [];
    List<Spawn> spawns = [];
    bool alphaSpawned = false;
    int currentSeed = seed;

    generatePokemon() {
      var spawn = generateSpawnLite(rng, spawnRng, alphaSpawned, pokemon)!;
      alphaSpawned = alphaSpawned || spawn.alpha;
      spawns.add(spawn);
    }

    reseed() {
      reseeds.add(ReseedSet(currentSeed.toHex(), spawns));
      currentSeed = rng.reseedWithNext();
      spawns = [];
      alphaSpawned = false;
    }

    advance() {
      advances.add(Advance(actions, reseeds));
      reseeds = [];
      actions = [];
    }

    for (var action in path) {
      actions.add(action);
      for (int i = 0; i < 4; i++) {
        generatePokemon();
      }
      reseed();
      for (int r = 0; r < action; r++) {
        generatePokemon();
        reseed();
      }
      advance();
    }

    return advances;
  }

  @override
  String toString() {
    return 'MassOutbreakResult{seed: $seed, path: $path, pokemon: $pokemon}';
  }
}

void fastSearch(List<Object> params) {
  SendPort sendPort = params[0] as SendPort;
  SearchParams sp = params[1] as SearchParams;

  bool matcher(Spawn spawn) {
    if (spawn == Spawn.DUMMY_ALPHA) {
      return false;
    }

    if (!sp.pkmn.isGenderFixed() && !(sp.male && sp.female)) {
      if (sp.male && spawn.gender != "M") {
        return false;
      }
      if (sp.female && spawn.gender != "F") {
        return false;
      }
    }

    return true;
  }

  List<int> pathSeedsState = List.generate(25, (index) => -1);
  List<int?> pathSeeds = List.generate(25, (index) => null);

  List<Spawn> currentMatches = []; //cleared for each path

  var rng = XOROSHIROLite();
  var spawnerRng = XOROSHIROLite();
  var lastPathLength = 1;

  for (var path in passivePaths(sp.spawns, maxDepth: 20)) {
    currentMatches.clear();

    if (lastPathLength < path.length) {
      lastPathLength = path.length;
      pathSeedsState.fillRange(0, path.length, -1);
    }

    for (var i = 0; i < path.length; i++) {
      var lastPathAction = pathSeedsState[i];
      var lastSeed = i == 0 ? sp.seed : pathSeeds[i - 1];
      var action = path[i];
      var isLast = i == path.length - 1;

      if (lastPathAction == action) {
        continue;
      } else if (lastPathAction == -1) {
        // we need to generate a new seed
        rng.reseed(lastSeed!);

        if (isLast && action == 0) {
          // we want to avoid advancing the seed here
          // it will be used to spawn pokemon
          pathSeeds[i] = lastSeed;
        } else {
          var newSeed = rng.advanceAndReseed(4);
          for (var i = 0; i < action; i++) {
            newSeed = rng.advanceAndReseed(1);
          }
          pathSeeds[i] = newSeed;
        }
      } else if (lastPathAction < action) {
        // extend actions
        var newSeed = pathSeeds[i];
        rng.reseed(newSeed!);
        if (isLast && lastPathAction == 0) {
          // we have to advance the seed
          newSeed = rng.advanceAndReseed(4);
        }
        for (var i = lastPathAction; i < action; i++) {
          newSeed = rng.advanceAndReseed(1);
        }
        pathSeeds[i] = newSeed;
        pathSeedsState.fillRange(i, path.length, -1);
      } else {
        throw StateError("Cannot process path: $path :: $lastPathAction >= $action");
      }

      pathSeedsState[i] = action;
    }

    var count = path.last == 0 ? 4 : 1;
    var spawnedAlpha = false;

    for (var i = 0; i < count; i++) {
      var spawn = generateSpawnLite(rng, spawnerRng, spawnedAlpha, sp.pkmn, alphaRequired: sp.alpha, shinyRequired: sp.shiny);

      if (spawn == null) {
        // wasn't alpha or shiny
        continue;
      }

      if (matcher(spawn)) {
        currentMatches.add(spawn);
      }

      if (sp.alpha && spawn.alpha) {
        // no more alphas will spawn
        break;
      }

      spawnedAlpha = spawnedAlpha || spawn.alpha;
    }

    if (currentMatches.isNotEmpty) {
      if (sp.multimatch) {
        if (!findAdditonalMatchInPath(sp.seed, path, sp.rolls, sp.pkmn, matcher, alphaRequired: sp.alpha, shinyRequired: sp.shiny)) {
          continue;
        }
      }

      sendPort.send(MassOutbreakResult(sp.seed, path, sp.pkmn));
      return;
    }

    // print("$path :: ${pathSeeds[path.length - 1].toHex()}");
  }
}

var _mainRng = XOROSHIROLite();
var _spawnerRng = XOROSHIROLite();

bool findAdditonalMatchInPath(int seed, List<int> path, int rolls, PokedexEntry pkmn, bool Function(Spawn spawn) matcher,
    {required bool alphaRequired, required bool shinyRequired}) {
  _mainRng.reseed(seed);

  for (var action in path) {
    bool spawnedAlpha = false;

    if (action == 0) {
      _mainRng.advanceAndReseed(4);
    } else {
      for (var i = -3; i < action; i++) {
        var spawn = generateSpawnLite(_mainRng, _spawnerRng, spawnedAlpha, pkmn, alphaRequired: alphaRequired, shinyRequired: shinyRequired);
        if (spawn != null) {
          spawnedAlpha = spawnedAlpha || spawn.alpha;

          if (matcher(spawn)) {
            return true;
          }
        }

        if (i >= 0) {
          _mainRng.reseedWithNext();
          spawnedAlpha = false;
        }
      }

      _mainRng.advanceAndReseed(1); // we don't check this one because we can't catch it.
    }
  }

  return false;
}

void isolatedSearch(SearchParams params, Function onTick, void Function(MassOutbreakResult?) onMatch) async {
  var receivePort = ReceivePort();
  var isolate = await Isolate.spawn(fastSearch, [receivePort.sendPort, params]);
  receivePort.listen((message) {
    if (message == null) {
      onMatch(null);
    } else if (message is int) {
      onTick();
    } else if (message is MassOutbreakResult) {
      onMatch(message);
      receivePort.close();
    }
  });
  receivePort.handleError((error) {
    print("Error in isolate :: $error");
  });
  isolate.addErrorListener(receivePort.sendPort);
}

class SearchParams {
  int seed;
  int spawns;
  int rolls;
  PokedexEntry pkmn;
  bool multimatch;

  //filters
  bool shiny;
  bool alpha;
  bool male;
  bool female;

  SearchParams(this.seed, this.spawns, this.rolls, this.pkmn, this.multimatch, this.shiny, this.alpha, this.male, this.female);

  @override
  String toString() {
    return 'SearchParams{seed: $seed, spawns: $spawns, rolls: $rolls, pkmn: $pkmn, multimatch: $multimatch, shiny: $shiny, alpha: $alpha, male: $male, female: $female}';
  }
}
