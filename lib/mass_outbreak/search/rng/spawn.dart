import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

const _natures = [
  "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
  "Bold", "Docile", "Relaxed", "Impish", "Lax",
  "Timid", "Hasty", "Serious", "Jolly", "Naive",
  "Modest", "Mild", "Quiet", "Bashful", "Rash",
  "Calm", "Gentle", "Sassy", "Careful", "Quirky"
];

final List<int> _evs = [
  List.filled(20, 0), // 0 to 19
  List.filled(6, 1), // 20 to 25
  List.filled(5, 2), // 26 to 30
  List.filled(1, 3) // 31
].expand((e) => e).toList();

class Spawn {
  static final UINT = BigInt.from(0xFFFFFFFF);
  static final USHORT = BigInt.from(0xFFFF);

  bool shiny;
  bool alpha;
  List<int> ivs;
  String evs;
  String gender;
  String nature;

  Spawn(this.shiny, this.alpha, this.ivs, this.gender, this.nature):
      evs = ivs.map((e) => _evs[e]).join("");

  static Spawn fromSeed(BigInt seed, PokedexEntry pkmn, bool alpha, int rolls) {
    var rng = XOROSHIRO();
    rng.reseed(seed);

    var ec = rng.rand(UINT);
    var sidtid = rng.rand(UINT);
    var pid = BigInt.zero;
    var shiny = false;

    for (int i = 0; i < rolls && !shiny; i++) {
      pid = rng.rand(UINT);
      shiny = (pid >> 16) ^ (sidtid >> 16) ^ (pid & USHORT) ^ (sidtid & USHORT) < BigInt.from(0x10);
    }

    List<int> ivs = List.filled(6, -1);

    if (alpha) {
      for (int p = 0; p < 3; p++) {
        var index = 0;
        do {
          index = (rng.rand(BigInt.from(6)) & USHORT).toInt();
        } while (ivs[index] != -1);
        ivs[index] = 31;
      }
    }

    for (int i = 0; i < 6; i++) {
      if (ivs[i] == -1) {
        ivs[i] = rng.rand(BigInt.from(32)).toInt();
      }
    }

    rng.rand(BigInt.two);

    String gender = "";

    if (pkmn.genderRatio == MALE_ONLY) {
      gender = "M";
    } else if (pkmn.genderRatio == FEMALE_ONLY) {
      gender = "F";
    } else if (pkmn.genderRatio == GENDERLESS) {
      gender = "G";
    } else {
      gender = (rng.rand(BigInt.from(252)) + BigInt.one).toInt() < pkmn.genderRatio ? "F" : "M";
    }

    var nature = _natures[rng.rand(BigInt.from(25)).toInt()];

    return Spawn(shiny, alpha, ivs, gender, nature);
  }
}
