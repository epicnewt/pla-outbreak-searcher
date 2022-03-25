import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

import '../../spawn.dart';

final ALPHA_LIMIT = BigInt.parse("FD7720F353A4BBFF", radix: 16);

final XOROSHIRO _mainRng = XOROSHIRO();
final XOROSHIRO _spawnerRng = XOROSHIRO();

List<Spawn> getFinalReseedOfPath(BigInt seed, PokedexEntry pkmn, List<int> path, int rolls) {
  _mainRng.reseed(seed);

  for (int i = 0; i < path.length - 1; i++) {
    //skip last
    for (int p = 0; p < 4; p++) {
      _mainRng.next();
      _mainRng.next();
    }
    _mainRng.reseed(_mainRng.next());

    for (int p = 0; p < path[i]; p++) {
      _mainRng.next();
      _mainRng.next();
      _mainRng.reseed(_mainRng.next());
    }
  }

  var lastAction = path.last;

  if (lastAction > 0) {
    for (int p = 0; p < 4; p++) {
      _mainRng.next();
      _mainRng.next();
    }
    _mainRng.reseed(_mainRng.next());

    for (int p = 1; p < lastAction; p++) {
      _mainRng.next();
      _mainRng.next();
      _mainRng.reseed(_mainRng.next());
    }
  }

  var spawn = lastAction == 0 ? 4 : 1;
  var spawnedAlpha = false;

  return List.generate(spawn, (index) => generateSpawn(_mainRng, _spawnerRng, spawnedAlpha, pkmn, rolls), growable: false);
}

Spawn generateSpawn(XOROSHIRO mainRng, XOROSHIRO spawnerRng, bool spawnedAlpha, PokedexEntry pkmn, int rolls) {
  spawnerRng.reseed(mainRng.next());
  mainRng.next();
  var alpha = (spawnerRng.next() > ALPHA_LIMIT) && !spawnedAlpha;
  return Spawn.fromSeed(spawnerRng.next(), pkmn, alpha, rolls);
}
