import 'dart:isolate';

import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/pass_path_generator.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/path_advancer.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/spawn.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

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
  final BigInt seed;
  final List<int> path;
  final PokedexEntry pokemon;

  MassOutbreakResult(this.seed, this.path, this.pokemon);

  List<Advance> advances(int rolls) {
    XOROSHIRO rng = XOROSHIRO();
    XOROSHIRO spawnRng = XOROSHIRO();
    rng.reseed(seed);

    List<Advance> advances = [];
    List<int> actions = [];
    List<ReseedSet> reseeds = [];
    List<Spawn> spawns = [];
    bool alphaSpawned = false;
    BigInt currentSeed = seed;

    generatePokemon() {
      var spawn = generateSpawn(rng, spawnRng, alphaSpawned, pokemon, rolls);
      alphaSpawned = alphaSpawned || spawn.alpha;
      spawns.add(spawn);
    }

    reseed() {
      reseeds.add(ReseedSet(currentSeed.toRadixString(16).toUpperCase(), spawns));
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

work(List<Object> params) {
  SendPort sendPort = params[0] as SendPort;
  SearchParams sp = params[1] as SearchParams;

  print(sp);

  bool matcher(Spawn spawn) {
    if (sp.shiny && !spawn.shiny) {
      return false;
    }
    if (sp.alpha && !spawn.alpha) {
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

  var count = 0;

  for (var path in passivePaths(sp.spawns, despawnLimit: sp.multimatch ? 5 : 15)) {
    if (++count % 64 == 0) {
      count = 0;
      sendPort.send(64);
    }

    var spawns = getFinalReseedOfPath(sp.seed, sp.pkmn, path, sp.rolls);
    var hasMatch = spawns.any(matcher);
    if (hasMatch) {
      var massOutbreakResult = MassOutbreakResult(sp.seed, path, sp.pkmn);
      if (sp.multimatch) {
        var advances = massOutbreakResult.advances(sp.rolls);
        for (var a in advances) {
          for (int i = 0; i < a.reseeds.length - 1; i++) {
            if (a.reseeds[i].spawns.any(matcher)) {
              try {
                sendPort.send(massOutbreakResult);
              } catch (e) {
                print(e);
              }
              return;
            }
          }
        }
        continue;
      }
      try {
        sendPort.send(massOutbreakResult);
      } catch (e) {
        print(e);
      }
      return;
    }
  }

  sendPort.send(null);
}

void isolatedSearch(SearchParams params, Function onTick, void Function(MassOutbreakResult?) onMatch) async {
  var receivePort = ReceivePort();
  var isolate = await Isolate.spawn(work, [receivePort.sendPort, params]);
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
  BigInt seed;
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
