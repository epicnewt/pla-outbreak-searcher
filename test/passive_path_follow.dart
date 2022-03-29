import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/pass_path_generator.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/path_advancer.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

main() {
  // toRadix(int n) {
  //   var h = (n >>> 60);
  //   if (h == 0) {
  //     return (n & 0xFFFFFFFFFFFFFFF).toRadixString(16);
  //   }
  //   return h.toRadixString(16) + (n & 0xFFFFFFFFFFFFFFF).toRadixString(16);
  // }

  // var s0 = 0;
  // var s1 = 0x82A2B175229D6A5B;
  // // var s1 = 0x8000000000000002;

  // var n = -2001;

  // for (var i = 1; i <= 17; i++) {
  //   print((n + i).toRadixString(16));
  //   print(toRadix(n + i));
  //   print(toRadix((((n >>> 1) + (i >> 1)) << 1) + ((n & 1) + (i & 1))));
  //   // print(toRadix(((n >>> 1) * (i << 1)) + (i * (n & 1))));
  //   // print(n / i);
  //   // print("${n ~/ i} :: ${(~n + 1) ~/ i}");
  //   print("");
  // }

  var sw = Stopwatch();
  int seed = 0x6D7EF76D7D09A47;
  PokedexEntry pkmn = pokedex[114]!;
  int rolls = 26;

  sw.start();
  fastSearch(seed, pkmn, rolls, true);
  sw.stop();
  print("Optimised alpha: ${sw.elapsed}");

  sw.reset();

  sw.start();
  fastSearch(seed, pkmn, rolls, false);
  sw.stop();
  print("Optimised reg: ${sw.elapsed}");

  sw.reset();

  sw.start();
  for (var path in genPaths()) {
    getFinalReseedOfPath(BigInt.parse("6D7EF76D7D09A47", radix: 16), pkmn, path, rolls);
  }
  sw.stop();
  print("Legacy: ${sw.elapsed}");
}

Iterable<List<int>> genPaths() sync* {
  yield* passivePaths(15, maxDepth: 20, despawnLimit: 11);
}

void fastSearch(int seed, PokedexEntry pkmn, int rolls, bool isAlpha) {
  List<int> pathSeedsState = List.generate(25, (index) => -1);
  List<int?> pathSeeds = List.generate(25, (index) => null);

  var rng = XOROSHIROLite();
  var spawnerRng = XOROSHIROLite();
  var lastPathLength = 1;

  for (var path in genPaths()) {
    if (lastPathLength < path.length) {
      lastPathLength = path.length;
      pathSeedsState.fillRange(0, path.length, -1);
    }

    for (var i = 0; i < path.length; i++) {
      var lastPathAction = pathSeedsState[i];
      var lastSeed = i == 0 ? seed : pathSeeds[i - 1];
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
        throw StateError(
            "Cannot process path: $path :: $lastPathAction >= $action");
      }

      pathSeedsState[i] = action;
    }

    var count = path.last == 0 ? 4 : 1;
    var spawnedAlpha = false;

    var finalSeed = rng.s0;

    for (var i = 0; i < count; i++) {
      var spawn = generateSpawnLite(rng, spawnerRng, spawnedAlpha, pkmn, rolls, alphaRequired: isAlpha);
      spawnedAlpha = spawnedAlpha || spawn.alpha;
    }

    // print("$path :: ${pathSeeds[path.length - 1].toHex()}");
  }
}
