import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:collection/collection.dart';

import 'package:mmo_searcher/pokedex/pokedex_store.dart';

final ALPHA_LIMIT_ULITE = 0xFD7720F353A4BBFF >>> 1;

const _natures = [
  "Hardy",
  "Lonely",
  "Brave",
  "Adamant",
  "Naughty",
  "Bold",
  "Docile",
  "Relaxed",
  "Impish",
  "Lax",
  "Timid",
  "Hasty",
  "Serious",
  "Jolly",
  "Naive",
  "Modest",
  "Mild",
  "Quiet",
  "Bashful",
  "Rash",
  "Calm",
  "Gentle",
  "Sassy",
  "Careful",
  "Quirky"
];

final List<int> _evs = [
  List.filled(20, 0), // 0 to 19
  List.filled(6, 1), // 20 to 25
  List.filled(5, 2), // 26 to 30
  List.filled(1, 3) // 31
].expand((e) => e).toList();

var _mainRng = XOROSHIRO();
var _mainRngLite = XOROSHIROLite();

class Spawn {
  static final Spawn DUMMY_ALPHA = Spawn(false, true, [], "", "", pkmn: pokedex[-1]!);
  static final UINT = BigInt.from(0xFFFFFFFF);
  static final USHORT = BigInt.from(0xFFFF);
  static final UINT_Lite = 0xFFFFFFFF;
  static final USHORT_Lite = 0xFFFF;

  final bool shiny;
  final bool alpha;
  final List<int> ivs;
  final String evs;
  final String gender;
  final String nature;
  final PokedexEntry pkmn;
  final String? form;

  Spawn(this.shiny, this.alpha, this.ivs, this.gender, this.nature, {required this.pkmn, String? this.form}) : evs = ivs.map((e) => _evs[e]).join("");

  static Spawn fromSeed(BigInt seed, PokedexEntry pkmn, bool alpha, int rolls) {
    _mainRng.reseed(seed);

    var ec = _mainRng.rand(UINT);
    var sidtid = _mainRng.rand(UINT);
    var pid = BigInt.zero;
    var shiny = false;

    for (int i = 0; i < rolls && !shiny; i++) {
      pid = _mainRng.rand(UINT);
      shiny = (pid >> 16) ^ (sidtid >> 16) ^ (pid & USHORT) ^ (sidtid & USHORT) < BigInt.from(0x10);
    }

    List<int> ivs = List.filled(6, -1);

    if (alpha) {
      for (int p = 0; p < 3; p++) {
        var index = 0;
        do {
          index = (_mainRng.rand(BigInt.from(6)) & USHORT).toInt();
        } while (ivs[index] != -1);
        ivs[index] = 31;
      }
    }

    for (int i = 0; i < 6; i++) {
      if (ivs[i] == -1) {
        ivs[i] = _mainRng.rand(BigInt.from(32)).toInt();
      }
    }

    _mainRng.rand(BigInt.two);

    String gender = "";

    if (pkmn.genderRatio == MALE_ONLY) {
      gender = "M";
    } else if (pkmn.genderRatio == FEMALE_ONLY) {
      gender = "F";
    } else if (pkmn.genderRatio == GENDERLESS) {
      gender = "G";
    } else {
      gender = (_mainRng.rand(BigInt.from(252)) + BigInt.one).toInt() < pkmn.genderRatio ? "F" : "M";
    }

    var nature = _natures[_mainRng.rand(BigInt.from(25)).toInt()];

    return Spawn(shiny, alpha, ivs, gender, nature, pkmn: pkmn);
  }

  static Spawn? fromSeedLite(int seed, PokedexEntry pkmn, bool alpha, int rolls, {int guranteedIVs = -1, bool shinyRequired = false, String? form}) {
    _mainRngLite.reseed(seed);

    var ec = _mainRngLite.rand(UINT_Lite);
    var sidtid = _mainRngLite.rand(UINT_Lite);
    var pid = 0;
    var shiny = false;

    for (int i = 0; i < rolls && !shiny; i++) {
      pid = _mainRngLite.rand(UINT_Lite);
      shiny = (pid >> 16) ^ (sidtid >> 16) ^ (pid & USHORT_Lite) ^ (sidtid & USHORT_Lite) < 0x10;
    }

    if (shinyRequired && !shiny) {
      return null;
    }

    List<int> ivs = List.filled(6, -1);

    if (alpha || guranteedIVs >= 0) {
      var perfectIVs = guranteedIVs == -1 ? 3 : guranteedIVs;
      for (int p = 0; p < perfectIVs; p++) {
        var index = 0;
        do {
          index = (_mainRngLite.rand(6) & USHORT_Lite).toInt();
        } while (ivs[index] != -1);
        ivs[index] = 31;
      }
    }

    for (int i = 0; i < 6; i++) {
      if (ivs[i] == -1) {
        ivs[i] = _mainRngLite.rand(32).toInt();
      }
    }

    _mainRngLite.rand(2);

    String gender = "";

    if (pkmn.genderRatio == MALE_ONLY) {
      gender = "M";
    } else if (pkmn.genderRatio == FEMALE_ONLY) {
      gender = "F";
    } else if (pkmn.genderRatio == GENDERLESS) {
      gender = "G";
    } else {
      gender = (_mainRngLite.rand(252) + 1).toInt() < pkmn.genderRatio ? "F" : "M";
    }

    var nature = _natures[_mainRngLite.rand(25).toInt()];

    return Spawn(shiny, alpha, ivs, gender, nature, pkmn: pkmn, form: form);
  }

  @override
  String toString() {
    return "$gender $evs $nature ${shiny ? '*' : ''} ${alpha ? 'Alpha' : ''} $pkmn".replaceAll(RegExp("\\s+"), " ").trim();
  }
}

Spawn? generateSpawnLite(XOROSHIROLite mainRng, XOROSHIROLite spawnerRng, bool spawnedAlpha, PokedexEntry? pkmn,
    {EncounterTable? encounterTable, bool alphaRequired = false, bool shinyRequired = false, bool debug = false}) {
  if (debug) {
    print("generateSpawnLite($mainRng)");
  }
  spawnerRng.reseed(mainRng.next());
  mainRng.next();

  var encounterSlotSeed = spawnerRng.next();
  var encounterSlot = (encounterTable ?? EncounterTable.massoutbreak).findSlot(encounterSlotSeed);
  var alpha = encounterSlot.alpha;

  if (alphaRequired && !alpha) {
    return null;
  }

  var guarateedIVs = encounterSlot.ivs;

  late Spawn? _default = alpha ? Spawn.DUMMY_ALPHA : null;

  PokedexEntry pokedexEntry = pkmn ?? encounterSlot.pkmn;
  var fromSeedLite = Spawn.fromSeedLite(
    spawnerRng.next(),
    pokedexEntry,
    alpha,
    getRolls(pokedexEntry.pokemon),
    shinyRequired: shinyRequired,
    guranteedIVs: guarateedIVs,
    form: encounterSlot.form,
  );
  return fromSeedLite ?? _default;
}

int getRolls(String pokemon) {
  var store = GetIt.I.get<PokedexStore>();
  return [
    store.pokedexCompletion[pokemon] ?? false,
    store.pokedexPerfection[pokemon] ?? false,
    store.shinyCharm,
  ].mapIndexed((index, element) => (element) ? index + 1 : 0).sum;
}
