import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

import '../../spawn.dart';

final ALPHA_LIMIT = BigInt.parse("FD7720F353A4BBFF", radix: 16);
// final ALPHA_LIMIT_LITE = 0xFD7720F353A4BBFF;
final ALPHA_LIMIT_LITE_PARITY = 1;

final XOROSHIRO _mainRng = XOROSHIRO();
final XOROSHIRO _spawnerRng = XOROSHIRO();

@Deprecated("message")
List<Spawn> getFinalReseedOfPath(BigInt seed, PokedexEntry pkmn, List<int> path, int rolls) {
  _mainRng.reseed(seed);

  void spawn(int n) {
    for (int p = 0; p < n; p++) {
      _mainRng.next();
      _mainRng.next();
    }
    _mainRng.reseed(_mainRng.next());
  }

  for (int i = 0; i < path.length - 1; i++) {
    //skip last
    spawn(4);

    for (int p = 0; p < path[i]; p++) {
      spawn(1);
    }
  }

  var lastAction = path.last;

  if (lastAction > 0) {
    spawn(4);

    for (int p = 1; p < lastAction; p++) {
      spawn(1);
    }
  }

  var count = lastAction == 0 ? 4 : 1;
  var spawnedAlpha = false;

  return List.generate(count, (index) {
    var spawn = generateSpawn(_mainRng, _spawnerRng, spawnedAlpha, pkmn, rolls);
    spawnedAlpha = spawnedAlpha || spawn.alpha;
    return spawn;
  }, growable: false);
}

Spawn generateSpawn(XOROSHIRO mainRng, XOROSHIRO spawnerRng, bool spawnedAlpha, PokedexEntry pkmn, int rolls) {
  spawnerRng.reseed(mainRng.next());
  mainRng.next();
  var alpha = (spawnerRng.next() > ALPHA_LIMIT) && !spawnedAlpha;
  return Spawn.fromSeed(spawnerRng.next(), pkmn, alpha, rolls);
}
