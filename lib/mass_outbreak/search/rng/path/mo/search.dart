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
}

MassOutbreakResult? searchMassOutbreak(BigInt seed, int spawns, int rolls, PokedexEntry pkmn, bool Function(Spawn) matcher) {
  for (var path in passivePaths(spawns)) {
    var spawns = getFinalReseedOfPath(seed, pkmn, path, rolls);
    var hasMatch = spawns.any(matcher);
    if (hasMatch) {
      print("Found match: ${path.join("|")}");
      for (var e in spawns) {
        print("  ${e.gender} ${e.evs} ${e.nature} ${e.shiny} ${e.alpha}");
      }
      return MassOutbreakResult(seed, path, pkmn);
    }
  }
  return null;
}
