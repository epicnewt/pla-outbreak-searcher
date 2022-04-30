import 'package:mmo_searcher/big_num.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class EncounterTable {
  static final EncounterTable massoutbreak = EncounterTable([
    EncounterSlot.fromMap({"slot": "FD7720F353A4BBFF".parseBigInt(), "name": 'Non-Alpha', "pkmn": pokedex[-1]!, "alpha": false, "level": [], "ivs": 0}),
    EncounterSlot.fromMap({"slot": "FFFFFFFFFFFFFFFF".parseBigInt(), "name": 'Alpha', "pkmn": pokedex[-1]!, "alpha": true, "level": [], "ivs": 3})
  ]);

  final List<EncounterSlot> slots;
  const EncounterTable(this.slots);

  EncounterSlot findSlot(int seed) {
    var seedBI = BigInt.parse(seed.toHex(), radix: 16);

    var last = BigInt.zero;
    for (var i = 0; i < slots.length; i++) {
      var next = slots[i].slot;

      if (last < seedBI && seedBI <= next) {
        return slots[i];
      }

      last = next;
    }

    return slots.last;
  }
}

class EncounterSlot {
  final Map<String, Object> _data;

  const EncounterSlot(this._data);
  const EncounterSlot.fromMap(Map<String, Object> data) : this(data);

  BigInt get slot => _data['slot']! as BigInt;
  String get name => _data['name']! as String;
  bool get alpha => _data['alpha']! as bool;
  List<int> get level => _data['level']! as List<int>;
  int get ivs => _data['ivs']! as int;
  String? get form => _data['form'] as String?;

  PokedexEntry get pkmn {
    if (_data['pkmn'] == null) {
      print("Cannot find dex entry: ${name}");
    }
    return _data['pkmn'] as PokedexEntry;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${[slot, name, alpha]}";
  }
}

Map<String, EncounterTable> encounterSlotsMap = {
  "7FA3A1DE69BD271E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Raichu",
      "pkmn": findDexEntry("Raichu"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Raichu",
      "pkmn": findDexEntry("Raichu"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "44182A854CD372AA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Raichu",
      "pkmn": findDexEntry("Raichu"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Raichu",
      "pkmn": findDexEntry("Raichu"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "44182B854CD3745D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "441828854CD36F44": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Raichu",
      "pkmn": findDexEntry("Raichu"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B6A506CF7BC718EF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Zubat",
      "pkmn": findDexEntry("Zubat"),
      "alpha": false,
      "level": [19, 21],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Zubat",
      "pkmn": findDexEntry("Zubat"),
      "alpha": true,
      "level": [34, 36],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "7CCC8F76604EF8FB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "7CCC8E76604EF748": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Zubat",
      "pkmn": findDexEntry("Zubat"),
      "alpha": true,
      "level": [34, 36],
      "ivs": 4
    })
  ]),
  "7CCC9176604EFC61": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "AE0FB59D11E10887": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Crobat",
      "pkmn": findDexEntry("Crobat"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Crobat",
      "pkmn": findDexEntry("Crobat"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "A331DBB81B1FC43": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Crobat",
      "pkmn": findDexEntry("Crobat"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Crobat",
      "pkmn": findDexEntry("Crobat"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "A331CBB81B1FA90": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golbat",
      "pkmn": findDexEntry("Golbat"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "A331FBB81B1FFA9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Crobat",
      "pkmn": findDexEntry("Crobat"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "41E4947058A65FD8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Paras",
      "pkmn": findDexEntry("Paras"),
      "alpha": false,
      "level": [21, 23],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Paras",
      "pkmn": findDexEntry("Paras"),
      "alpha": true,
      "level": [36, 38],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Parasect",
      "pkmn": findDexEntry("Parasect"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Parasect",
      "pkmn": findDexEntry("Parasect"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "702EDC94E9044B34": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Parasect",
      "pkmn": findDexEntry("Parasect"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Parasect",
      "pkmn": findDexEntry("Parasect"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "702EDD94E9044CE7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Paras",
      "pkmn": findDexEntry("Paras"),
      "alpha": true,
      "level": [36, 38],
      "ivs": 4
    })
  ]),
  "702EDE94E9044E9A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Parasect",
      "pkmn": findDexEntry("Parasect"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "21C03B7FF717BBAB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Abra",
      "pkmn": findDexEntry("Abra"),
      "alpha": false,
      "level": [13, 15],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Abra",
      "pkmn": findDexEntry("Abra"),
      "alpha": true,
      "level": [28, 30],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "87D933E515710A7F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "87D932E5157108CC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Abra",
      "pkmn": findDexEntry("Abra"),
      "alpha": true,
      "level": [28, 30],
      "ivs": 4
    })
  ]),
  "87D935E515710DE5": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "2636AF8BB69216A3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Alakazam",
      "pkmn": findDexEntry("Alakazam"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Alakazam",
      "pkmn": findDexEntry("Alakazam"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "CBC6C76D483390E7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Alakazam",
      "pkmn": findDexEntry("Alakazam"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Alakazam",
      "pkmn": findDexEntry("Alakazam"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "CBC6C66D48338F34": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kadabra",
      "pkmn": findDexEntry("Kadabra"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "CBC6C96D4833944D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Alakazam",
      "pkmn": findDexEntry("Alakazam"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "E680740C6BE14EFB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Geodude",
      "pkmn": findDexEntry("Geodude"),
      "alpha": false,
      "level": [22, 24],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Geodude",
      "pkmn": findDexEntry("Geodude"),
      "alpha": true,
      "level": [37, 39],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "2058EB6587596EEF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "2058EA6587596D3C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Geodude",
      "pkmn": findDexEntry("Geodude"),
      "alpha": true,
      "level": [37, 39],
      "ivs": 4
    })
  ]),
  "2058ED6587597255": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "7A36227F4C2CC35D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Golem",
      "pkmn": findDexEntry("Golem"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golem",
      "pkmn": findDexEntry("Golem"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "B5C199D8691677D1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Golem",
      "pkmn": findDexEntry("Golem"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golem",
      "pkmn": findDexEntry("Golem"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B5C198D86916761E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Graveler",
      "pkmn": findDexEntry("Graveler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "B5C197D86916746B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golem",
      "pkmn": findDexEntry("Golem"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "8E51750B5EB775A0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Ponyta",
      "pkmn": findDexEntry("Ponyta"),
      "alpha": false,
      "level": [37, 39],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Ponyta",
      "pkmn": findDexEntry("Ponyta"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Rapidash",
      "pkmn": findDexEntry("Rapidash"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rapidash",
      "pkmn": findDexEntry("Rapidash"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "53327DB24229B98C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Rapidash",
      "pkmn": findDexEntry("Rapidash"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rapidash",
      "pkmn": findDexEntry("Rapidash"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "53327EB24229BB3F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ponyta",
      "pkmn": findDexEntry("Ponyta"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 4
    })
  ]),
  "53327FB24229BCF2": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rapidash",
      "pkmn": findDexEntry("Rapidash"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "DEDBA54CA00F14E4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Scyther",
      "pkmn": findDexEntry("Scyther"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Scyther",
      "pkmn": findDexEntry("Scyther"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Kleavor",
      "pkmn": findDexEntry("Kleavor"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kleavor",
      "pkmn": findDexEntry("Kleavor"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "2E2A5E3683B037E8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Kleavor",
      "pkmn": findDexEntry("Kleavor"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kleavor",
      "pkmn": findDexEntry("Kleavor"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "2E2A5F3683B0399B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Scyther",
      "pkmn": findDexEntry("Scyther"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "2E2A603683B03B4E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kleavor",
      "pkmn": findDexEntry("Kleavor"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "4EBAFDB3F3D274CD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Pichu",
      "pkmn": findDexEntry("Pichu"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Pichu",
      "pkmn": findDexEntry("Pichu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "88C23617D6BA8461": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "88C23517D6BA82AE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pichu",
      "pkmn": findDexEntry("Pichu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "88C23417D6BA80FB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pikachu",
      "pkmn": findDexEntry("Pikachu"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "5BFA9CCA4ED8142B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Stantler",
      "pkmn": findDexEntry("Stantler"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Stantler",
      "pkmn": findDexEntry("Stantler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Wyrdeer",
      "pkmn": findDexEntry("Wyrdeer"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Wyrdeer",
      "pkmn": findDexEntry("Wyrdeer"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "C213952F6D3162FF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Wyrdeer",
      "pkmn": findDexEntry("Wyrdeer"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Wyrdeer",
      "pkmn": findDexEntry("Wyrdeer"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "C213942F6D31614C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Stantler",
      "pkmn": findDexEntry("Stantler"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "C213972F6D316665": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Wyrdeer",
      "pkmn": findDexEntry("Wyrdeer"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B5EE09F298C830F4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Wurmple",
      "pkmn": findDexEntry("Wurmple"),
      "alpha": false,
      "level": [4, 6],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Wurmple",
      "pkmn": findDexEntry("Wurmple"),
      "alpha": true,
      "level": [19, 21],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 3
    })
  ]),
  "311EC1D2F068F098": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "311EC2D2F068F24B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Wurmple",
      "pkmn": findDexEntry("Wurmple"),
      "alpha": true,
      "level": [19, 21],
      "ivs": 4
    })
  ]),
  "311EC3D2F068F3FE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "E35FD9B2D7A94E6F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Wurmple",
      "pkmn": findDexEntry("Wurmple"),
      "alpha": false,
      "level": [4, 6],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Wurmple",
      "pkmn": findDexEntry("Wurmple"),
      "alpha": true,
      "level": [19, 21],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 3
    })
  ]),
  "A9876259BC312E7B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "A9876159BC312CC8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Wurmple",
      "pkmn": findDexEntry("Wurmple"),
      "alpha": true,
      "level": [19, 21],
      "ivs": 4
    })
  ]),
  "A9876459BC3131E1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "581DE2E85BA38AEC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Beautifly",
      "pkmn": findDexEntry("Beautifly"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Beautifly",
      "pkmn": findDexEntry("Beautifly"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "933C5A4178306D80": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Beautifly",
      "pkmn": findDexEntry("Beautifly"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Beautifly",
      "pkmn": findDexEntry("Beautifly"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "933C5B4178306F33": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Silcoon",
      "pkmn": findDexEntry("Silcoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "933C5C41783070E6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Beautifly",
      "pkmn": findDexEntry("Beautifly"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "5182B16F9EC5667A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Dustox",
      "pkmn": findDexEntry("Dustox"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dustox",
      "pkmn": findDexEntry("Dustox"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "8B8A69D381AE4F8E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Dustox",
      "pkmn": findDexEntry("Dustox"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dustox",
      "pkmn": findDexEntry("Dustox"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "8B8A6AD381AE5141": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Cascoon",
      "pkmn": findDexEntry("Cascoon"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "8B8A67D381AE4C28": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dustox",
      "pkmn": findDexEntry("Dustox"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "8F1EDD81805EF8A4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Spheal",
      "pkmn": findDexEntry("Spheal"),
      "alpha": false,
      "level": [29, 31],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Spheal",
      "pkmn": findDexEntry("Spheal"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": false,
      "level": [41, 43],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": true,
      "level": [56, 58],
      "ivs": 3
    })
  ]),
  "DE6D966B64001BA8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": false,
      "level": [41, 43],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": true,
      "level": [56, 58],
      "ivs": 4
    })
  ]),
  "DE6D976B64001D5B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Spheal",
      "pkmn": findDexEntry("Spheal"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 4
    })
  ]),
  "DE6D986B64001F0E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": true,
      "level": [56, 58],
      "ivs": 4
    })
  ]),
  "2E9A27B02954F177": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Chimchar",
      "pkmn": findDexEntry("Chimchar"),
      "alpha": false,
      "level": [11, 13],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Chimchar",
      "pkmn": findDexEntry("Chimchar"),
      "alpha": true,
      "level": [26, 28],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    })
  ]),
  "9AA8EC77FB41C53": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "9AA8DC77FB41AA0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chimchar",
      "pkmn": findDexEntry("Chimchar"),
      "alpha": true,
      "level": [26, 28],
      "ivs": 4
    })
  ]),
  "9AA90C77FB41FB9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "AEFE8B222374C781": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Infernape",
      "pkmn": findDexEntry("Infernape"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Infernape",
      "pkmn": findDexEntry("Infernape"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "203952BBCC8C88ED": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Infernape",
      "pkmn": findDexEntry("Infernape"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Infernape",
      "pkmn": findDexEntry("Infernape"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "203951BBCC8C873A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Monferno",
      "pkmn": findDexEntry("Monferno"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "203950BBCC8C8587": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Infernape",
      "pkmn": findDexEntry("Infernape"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "B76A7F0C08A5D3BC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Starly",
      "pkmn": findDexEntry("Starly"),
      "alpha": false,
      "level": [11, 13],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Starly",
      "pkmn": findDexEntry("Starly"),
      "alpha": true,
      "level": [26, 28],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": false,
      "level": [31, 33],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 3
    })
  ]),
  "9DFAB76D78A429F0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": false,
      "level": [31, 33],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 4
    })
  ]),
  "9DFAB86D78A42BA3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Starly",
      "pkmn": findDexEntry("Starly"),
      "alpha": true,
      "level": [26, 28],
      "ivs": 4
    })
  ]),
  "9DFAB96D78A42D56": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 4
    })
  ]),
  "5F4F11A6FCD08365": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": false,
      "level": [31, 33],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Staraptor",
      "pkmn": findDexEntry("Staraptor"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staraptor",
      "pkmn": findDexEntry("Staraptor"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "47289888E15CEE9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Staraptor",
      "pkmn": findDexEntry("Staraptor"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staraptor",
      "pkmn": findDexEntry("Staraptor"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "47288888E15CD36": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staravia",
      "pkmn": findDexEntry("Staravia"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 4
    })
  ]),
  "47287888E15CB83": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Staraptor",
      "pkmn": findDexEntry("Staraptor"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "AABDAAF4803C7B93": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Bidoof",
      "pkmn": findDexEntry("Bidoof"),
      "alpha": false,
      "level": [12, 14],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Bidoof",
      "pkmn": findDexEntry("Bidoof"),
      "alpha": true,
      "level": [27, 29],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Bibarel",
      "pkmn": findDexEntry("Bibarel"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bibarel",
      "pkmn": findDexEntry("Bibarel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "CFAD43DD29DD50B7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Bibarel",
      "pkmn": findDexEntry("Bibarel"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bibarel",
      "pkmn": findDexEntry("Bibarel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "CFAD42DD29DD4F04": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bidoof",
      "pkmn": findDexEntry("Bidoof"),
      "alpha": true,
      "level": [27, 29],
      "ivs": 4
    })
  ]),
  "CFAD45DD29DD541D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bibarel",
      "pkmn": findDexEntry("Bibarel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "983077E222F88D07": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Kricketot",
      "pkmn": findDexEntry("Kricketot"),
      "alpha": false,
      "level": [7, 9],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Kricketot",
      "pkmn": findDexEntry("Kricketot"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Kricketune",
      "pkmn": findDexEntry("Kricketune"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kricketune",
      "pkmn": findDexEntry("Kricketune"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "F453E00092C980C3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Kricketune",
      "pkmn": findDexEntry("Kricketune"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kricketune",
      "pkmn": findDexEntry("Kricketune"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "F453DF0092C97F10": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kricketot",
      "pkmn": findDexEntry("Kricketot"),
      "alpha": true,
      "level": [22, 24],
      "ivs": 4
    })
  ]),
  "F453E20092C98429": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kricketune",
      "pkmn": findDexEntry("Kricketune"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "C0272DE866874B95": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Shinx",
      "pkmn": findDexEntry("Shinx"),
      "alpha": false,
      "level": [12, 14],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Shinx",
      "pkmn": findDexEntry("Shinx"),
      "alpha": true,
      "level": [27, 29],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    })
  ]),
  "E4AA26D10FCBF1F9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "E4AA25D10FCBF046": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Shinx",
      "pkmn": findDexEntry("Shinx"),
      "alpha": true,
      "level": [27, 29],
      "ivs": 4
    })
  ]),
  "E4AA24D10FCBEE93": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "ABA3272412310022": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Luxray",
      "pkmn": findDexEntry("Luxray"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxray",
      "pkmn": findDexEntry("Luxray"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "FAF1600DF5D149A6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Luxray",
      "pkmn": findDexEntry("Luxray"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxray",
      "pkmn": findDexEntry("Luxray"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "FAF1610DF5D14B59": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxio",
      "pkmn": findDexEntry("Luxio"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "FAF15E0DF5D14640": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Luxray",
      "pkmn": findDexEntry("Luxray"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "6456E4C45D4447DD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Buizel",
      "pkmn": findDexEntry("Buizel"),
      "alpha": false,
      "level": [23, 25],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Buizel",
      "pkmn": findDexEntry("Buizel"),
      "alpha": true,
      "level": [38, 40],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Floatzel",
      "pkmn": findDexEntry("Floatzel"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Floatzel",
      "pkmn": findDexEntry("Floatzel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "9FE25C1D7A2DFC51": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Floatzel",
      "pkmn": findDexEntry("Floatzel"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Floatzel",
      "pkmn": findDexEntry("Floatzel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "9FE25B1D7A2DFA9E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Buizel",
      "pkmn": findDexEntry("Buizel"),
      "alpha": true,
      "level": [38, 40],
      "ivs": 4
    })
  ]),
  "9FE25A1D7A2DF8EB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Floatzel",
      "pkmn": findDexEntry("Floatzel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "95E8E33C775F739A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Shellos-1",
      "pkmn": findDexEntry("Shellos"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Shellos-1",
      "pkmn": findDexEntry("Shellos"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gastrodon-1",
      "pkmn": findDexEntry("Gastrodon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gastrodon-1",
      "pkmn": findDexEntry("Gastrodon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "24AD9BA2CE46D8AE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gastrodon-1",
      "pkmn": findDexEntry("Gastrodon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gastrodon-1",
      "pkmn": findDexEntry("Gastrodon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "24AD9CA2CE46DA61": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Shellos-1",
      "pkmn": findDexEntry("Shellos"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "24AD99A2CE46D548": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gastrodon-1",
      "pkmn": findDexEntry("Gastrodon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "267C94C0E8327C6D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Drifloon",
      "pkmn": findDexEntry("Drifloon"),
      "alpha": false,
      "level": [25, 27],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Drifloon",
      "pkmn": findDexEntry("Drifloon"),
      "alpha": true,
      "level": [40, 42],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Drifblim",
      "pkmn": findDexEntry("Drifblim"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drifblim",
      "pkmn": findDexEntry("Drifblim"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "B541CD273F1ABB01": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Drifblim",
      "pkmn": findDexEntry("Drifblim"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drifblim",
      "pkmn": findDexEntry("Drifblim"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B541CC273F1AB94E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drifloon",
      "pkmn": findDexEntry("Drifloon"),
      "alpha": true,
      "level": [40, 42],
      "ivs": 4
    })
  ]),
  "B541CB273F1AB79B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drifblim",
      "pkmn": findDexEntry("Drifblim"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "5B82458A398ABFA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Buneary",
      "pkmn": findDexEntry("Buneary"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Buneary",
      "pkmn": findDexEntry("Buneary"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Lopunny",
      "pkmn": findDexEntry("Lopunny"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lopunny",
      "pkmn": findDexEntry("Lopunny"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "3FBFDCBC8681950E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Lopunny",
      "pkmn": findDexEntry("Lopunny"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lopunny",
      "pkmn": findDexEntry("Lopunny"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "3FBFDDBC868196C1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Buneary",
      "pkmn": findDexEntry("Buneary"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "3FBFDABC868191A8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lopunny",
      "pkmn": findDexEntry("Lopunny"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "4418CAFB9AE0F8F7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Mime Jr.",
      "pkmn": findDexEntry("Mime Jr."),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Mime Jr.",
      "pkmn": findDexEntry("Mime Jr."),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Mr. Mime",
      "pkmn": findDexEntry("Mr. Mime"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mr. Mime",
      "pkmn": findDexEntry("Mr. Mime"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "1F293212F14023D3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Mr. Mime",
      "pkmn": findDexEntry("Mr. Mime"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mr. Mime",
      "pkmn": findDexEntry("Mr. Mime"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1F293112F1402220": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mime Jr.",
      "pkmn": findDexEntry("Mime Jr."),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "1F293412F1402739": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mr. Mime",
      "pkmn": findDexEntry("Mr. Mime"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "69F12B63EF3B0D93": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Chatot",
      "pkmn": findDexEntry("Chatot"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chatot",
      "pkmn": findDexEntry("Chatot"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "8EE0C44C98DBE2B7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chatot",
      "pkmn": findDexEntry("Chatot"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "5C4B06CB0F089DED": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Munchlax",
      "pkmn": findDexEntry("Munchlax"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Munchlax",
      "pkmn": findDexEntry("Munchlax"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Snorlax",
      "pkmn": findDexEntry("Snorlax"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Snorlax",
      "pkmn": findDexEntry("Snorlax"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "EB103F3165F0DC81": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Snorlax",
      "pkmn": findDexEntry("Snorlax"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Snorlax",
      "pkmn": findDexEntry("Snorlax"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "EB103E3165F0DACE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Munchlax",
      "pkmn": findDexEntry("Munchlax"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "EB103D3165F0D91B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Snorlax",
      "pkmn": findDexEntry("Snorlax"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "DA1D5C5459E77470": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Zorua-1",
      "pkmn": findDexEntry("Zorua"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Zorua-1",
      "pkmn": findDexEntry("Zorua"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Zoroark-1",
      "pkmn": findDexEntry("Zoroark"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Zoroark-1",
      "pkmn": findDexEntry("Zoroark"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "F38D23F2E9E91E3C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Zoroark-1",
      "pkmn": findDexEntry("Zoroark"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Zoroark-1",
      "pkmn": findDexEntry("Zoroark"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "F38D24F2E9E91FEF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Zorua-1",
      "pkmn": findDexEntry("Zorua"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "F38D25F2E9E921A2": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Zoroark-1",
      "pkmn": findDexEntry("Zoroark"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B882ECC92227591": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Psyduck",
      "pkmn": findDexEntry("Psyduck"),
      "alpha": false,
      "level": [30, 32],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Psyduck",
      "pkmn": findDexEntry("Psyduck"),
      "alpha": true,
      "level": [45, 47],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Golduck",
      "pkmn": findDexEntry("Golduck"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golduck",
      "pkmn": findDexEntry("Golduck"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "CFFCB7737538C11D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Golduck",
      "pkmn": findDexEntry("Golduck"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golduck",
      "pkmn": findDexEntry("Golduck"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "CFFCB6737538BF6A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Psyduck",
      "pkmn": findDexEntry("Psyduck"),
      "alpha": true,
      "level": [45, 47],
      "ivs": 4
    })
  ]),
  "CFFCB5737538BDB7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Golduck",
      "pkmn": findDexEntry("Golduck"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "22B4B9D8EC78A773": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Gastly",
      "pkmn": findDexEntry("Gastly"),
      "alpha": false,
      "level": [22, 24],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Gastly",
      "pkmn": findDexEntry("Gastly"),
      "alpha": true,
      "level": [37, 39],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "47A452C196197C97": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "47A451C196197AE4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gastly",
      "pkmn": findDexEntry("Gastly"),
      "alpha": true,
      "level": [37, 39],
      "ivs": 4
    })
  ]),
  "47A454C196197FFD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "A18BCA1FBA797769": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gengar",
      "pkmn": findDexEntry("Gengar"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gengar",
      "pkmn": findDexEntry("Gengar"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "FC68523E29342BE5": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gengar",
      "pkmn": findDexEntry("Gengar"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gengar",
      "pkmn": findDexEntry("Gengar"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "FC68513E29342A32": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Haunter",
      "pkmn": findDexEntry("Haunter"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "FC68503E2934287F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gengar",
      "pkmn": findDexEntry("Gengar"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "6B42457F1C3F5457": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Onix",
      "pkmn": findDexEntry("Onix"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Onix",
      "pkmn": findDexEntry("Onix"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Steelix",
      "pkmn": findDexEntry("Steelix"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Steelix",
      "pkmn": findDexEntry("Steelix"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "4652AC96729E7F33": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Steelix",
      "pkmn": findDexEntry("Steelix"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Steelix",
      "pkmn": findDexEntry("Steelix"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "4652AB96729E7D80": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Onix",
      "pkmn": findDexEntry("Onix"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "4652AE96729E8299": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Steelix",
      "pkmn": findDexEntry("Steelix"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "CD9D902584FADC0B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Lickitung",
      "pkmn": findDexEntry("Lickitung"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Lickitung",
      "pkmn": findDexEntry("Lickitung"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Lickilicky",
      "pkmn": findDexEntry("Lickilicky"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lickilicky",
      "pkmn": findDexEntry("Lickilicky"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "3204088AA1E36FDF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Lickilicky",
      "pkmn": findDexEntry("Lickilicky"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lickilicky",
      "pkmn": findDexEntry("Lickilicky"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "3204078AA1E36E2C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lickitung",
      "pkmn": findDexEntry("Lickitung"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "32040A8AA1E37345": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lickilicky",
      "pkmn": findDexEntry("Lickilicky"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "CBC824216CF129E5": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Rhyhorn",
      "pkmn": findDexEntry("Rhyhorn"),
      "alpha": false,
      "level": [39, 41],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Rhyhorn",
      "pkmn": findDexEntry("Rhyhorn"),
      "alpha": true,
      "level": [54, 56],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "70EB9C02FE367569": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "70EB9B02FE3673B6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhyhorn",
      "pkmn": findDexEntry("Rhyhorn"),
      "alpha": true,
      "level": [54, 56],
      "ivs": 4
    })
  ]),
  "70EB9A02FE367203": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "DE62430A26019073": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Rhyperior",
      "pkmn": findDexEntry("Rhyperior"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhyperior",
      "pkmn": findDexEntry("Rhyperior"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "351DBF2CFA26597": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Rhyperior",
      "pkmn": findDexEntry("Rhyperior"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhyperior",
      "pkmn": findDexEntry("Rhyperior"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "351DAF2CFA263E4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhydon",
      "pkmn": findDexEntry("Rhydon"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "351DDF2CFA268FD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rhyperior",
      "pkmn": findDexEntry("Rhyperior"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "B348E127ECE2CE20": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Tangela",
      "pkmn": findDexEntry("Tangela"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Tangela",
      "pkmn": findDexEntry("Tangela"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Tangrowth",
      "pkmn": findDexEntry("Tangrowth"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tangrowth",
      "pkmn": findDexEntry("Tangrowth"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "7829E9CED055120C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Tangrowth",
      "pkmn": findDexEntry("Tangrowth"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tangrowth",
      "pkmn": findDexEntry("Tangrowth"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "7829EACED05513BF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tangela",
      "pkmn": findDexEntry("Tangela"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "7829EBCED0551572": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tangrowth",
      "pkmn": findDexEntry("Tangrowth"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1AC404AAAAAE96F0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Cyndaquil",
      "pkmn": findDexEntry("Cyndaquil"),
      "alpha": false,
      "level": [14, 16],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Cyndaquil",
      "pkmn": findDexEntry("Cyndaquil"),
      "alpha": true,
      "level": [29, 31],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    })
  ]),
  "3433CC493AB040BC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "3433CD493AB0426F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Cyndaquil",
      "pkmn": findDexEntry("Cyndaquil"),
      "alpha": true,
      "level": [29, 31],
      "ivs": 4
    })
  ]),
  "3433CE493AB04422": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "53F8FBC800ABF304": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Typhlosion-1",
      "pkmn": findDexEntry("Typhlosion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Typhlosion-1",
      "pkmn": findDexEntry("Typhlosion"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "4E89B4AF704CE708": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Typhlosion-1",
      "pkmn": findDexEntry("Typhlosion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Typhlosion-1",
      "pkmn": findDexEntry("Typhlosion"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "4E89B5AF704CE8BB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Quilava",
      "pkmn": findDexEntry("Quilava"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "4E89B6AF704CEA6E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Typhlosion-1",
      "pkmn": findDexEntry("Typhlosion"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "EBB267557307B5FF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Yanma",
      "pkmn": findDexEntry("Yanma"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Yanma",
      "pkmn": findDexEntry("Yanma"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Yanmega",
      "pkmn": findDexEntry("Yanmega"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Yanmega",
      "pkmn": findDexEntry("Yanmega"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "85996EF054AE672B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Yanmega",
      "pkmn": findDexEntry("Yanmega"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Yanmega",
      "pkmn": findDexEntry("Yanmega"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "85996DF054AE6578": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Yanma",
      "pkmn": findDexEntry("Yanma"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "859970F054AE6A91": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Yanmega",
      "pkmn": findDexEntry("Yanmega"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "39A6B2692D9CA51": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Murkrow",
      "pkmn": findDexEntry("Murkrow"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Murkrow",
      "pkmn": findDexEntry("Murkrow"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Honchkrow",
      "pkmn": findDexEntry("Honchkrow"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Honchkrow",
      "pkmn": findDexEntry("Honchkrow"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "C80EF3CD75F015DD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Honchkrow",
      "pkmn": findDexEntry("Honchkrow"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Honchkrow",
      "pkmn": findDexEntry("Honchkrow"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "C80EF2CD75F0142A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Murkrow",
      "pkmn": findDexEntry("Murkrow"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "C80EF1CD75F01277": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Honchkrow",
      "pkmn": findDexEntry("Honchkrow"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "C756FF484B9DD6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Swinub",
      "pkmn": findDexEntry("Swinub"),
      "alpha": false,
      "level": [30, 32],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Swinub",
      "pkmn": findDexEntry("Swinub"),
      "alpha": true,
      "level": [45, 47],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "87491F1EF21B9932": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "8749201EF21B9AE5": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Swinub",
      "pkmn": findDexEntry("Swinub"),
      "alpha": true,
      "level": [45, 47],
      "ivs": 4
    })
  ]),
  "87491D1EF21B95CC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "6D75099BA76E03B9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Teddiursa",
      "pkmn": findDexEntry("Teddiursa"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Teddiursa",
      "pkmn": findDexEntry("Teddiursa"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "48F210B2FE295D55": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "48F20FB2FE295BA2": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Teddiursa",
      "pkmn": findDexEntry("Teddiursa"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "48F20EB2FE2959EF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "AD190734A744BDEA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Ursaluna",
      "pkmn": findDexEntry("Ursaluna"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaluna",
      "pkmn": findDexEntry("Ursaluna"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "E8A47E8DC42E725E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Ursaluna",
      "pkmn": findDexEntry("Ursaluna"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaluna",
      "pkmn": findDexEntry("Ursaluna"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "E8A47F8DC42E7411": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaring",
      "pkmn": findDexEntry("Ursaring"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "E8A47C8DC42E6EF8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ursaluna",
      "pkmn": findDexEntry("Ursaluna"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "2B9EA24085244E5A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Roserade",
      "pkmn": findDexEntry("Roserade"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roserade",
      "pkmn": findDexEntry("Roserade"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "10E85AA1F40D086E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Roserade",
      "pkmn": findDexEntry("Roserade"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roserade",
      "pkmn": findDexEntry("Roserade"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "10E85BA1F40D0A21": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "10E858A1F40D0508": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roserade",
      "pkmn": findDexEntry("Roserade"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "3F66AF29D7FB4867": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Turtwig",
      "pkmn": findDexEntry("Turtwig"),
      "alpha": false,
      "level": [15, 17],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Turtwig",
      "pkmn": findDexEntry("Turtwig"),
      "alpha": true,
      "level": [30, 32],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": false,
      "level": [29, 31],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 3
    })
  ]),
  "99D697484659CE23": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": false,
      "level": [29, 31],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 4
    })
  ]),
  "99D696484659CC70": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Turtwig",
      "pkmn": findDexEntry("Turtwig"),
      "alpha": true,
      "level": [30, 32],
      "ivs": 4
    })
  ]),
  "99D699484659D189": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 4
    })
  ]),
  "B97BEC7AEBAFE187": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": false,
      "level": [29, 31],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Torterra",
      "pkmn": findDexEntry("Torterra"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Torterra",
      "pkmn": findDexEntry("Torterra"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "159F54995B80D543": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Torterra",
      "pkmn": findDexEntry("Torterra"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Torterra",
      "pkmn": findDexEntry("Torterra"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "159F53995B80D390": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Grotle",
      "pkmn": findDexEntry("Grotle"),
      "alpha": true,
      "level": [44, 46],
      "ivs": 4
    })
  ]),
  "159F56995B80D8A9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Torterra",
      "pkmn": findDexEntry("Torterra"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "4FE26D01FE772A10": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Budew",
      "pkmn": findDexEntry("Budew"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Budew",
      "pkmn": findDexEntry("Budew"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "1647B49E1BEB12DC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1647B59E1BEB148F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Budew",
      "pkmn": findDexEntry("Budew"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "1647B69E1BEB1642": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Roselia",
      "pkmn": findDexEntry("Roselia"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "44B4AE7881B41F32": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Pachirisu",
      "pkmn": findDexEntry("Pachirisu"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pachirisu",
      "pkmn": findDexEntry("Pachirisu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "BE32E658D7E423D6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Pachirisu",
      "pkmn": findDexEntry("Pachirisu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "519961D10096CFF3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Stunky",
      "pkmn": findDexEntry("Stunky"),
      "alpha": false,
      "level": [31, 33],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Stunky",
      "pkmn": findDexEntry("Stunky"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Skuntank",
      "pkmn": findDexEntry("Skuntank"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Skuntank",
      "pkmn": findDexEntry("Skuntank"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "7688FAB9AA37A517": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Skuntank",
      "pkmn": findDexEntry("Skuntank"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Skuntank",
      "pkmn": findDexEntry("Skuntank"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "7688F9B9AA37A364": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Stunky",
      "pkmn": findDexEntry("Stunky"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 4
    })
  ]),
  "7688FCB9AA37A87D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Skuntank",
      "pkmn": findDexEntry("Skuntank"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "A26B38E34424A441": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Bronzor",
      "pkmn": findDexEntry("Bronzor"),
      "alpha": false,
      "level": [30, 32],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Bronzor",
      "pkmn": findDexEntry("Bronzor"),
      "alpha": true,
      "level": [45, 47],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Bronzong",
      "pkmn": findDexEntry("Bronzong"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bronzong",
      "pkmn": findDexEntry("Bronzong"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "BD210081D53B10AD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Bronzong",
      "pkmn": findDexEntry("Bronzong"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bronzong",
      "pkmn": findDexEntry("Bronzong"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "BD20FF81D53B0EFA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bronzor",
      "pkmn": findDexEntry("Bronzor"),
      "alpha": true,
      "level": [45, 47],
      "ivs": 4
    })
  ]),
  "BD20FE81D53B0D47": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bronzong",
      "pkmn": findDexEntry("Bronzong"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "E4A58F1740AD777": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Bonsly",
      "pkmn": findDexEntry("Bonsly"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Bonsly",
      "pkmn": findDexEntry("Bonsly"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Sudowoodo",
      "pkmn": findDexEntry("Sudowoodo"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sudowoodo",
      "pkmn": findDexEntry("Sudowoodo"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "E95AC008CA6A0253": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Sudowoodo",
      "pkmn": findDexEntry("Sudowoodo"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sudowoodo",
      "pkmn": findDexEntry("Sudowoodo"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "E95ABF08CA6A00A0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bonsly",
      "pkmn": findDexEntry("Bonsly"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "E95AC208CA6A05B9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sudowoodo",
      "pkmn": findDexEntry("Sudowoodo"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "27017E5B2F0EE5B6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Spiritomb",
      "pkmn": findDexEntry("Spiritomb"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Spiritomb",
      "pkmn": findDexEntry("Spiritomb"),
      "alpha": true,
      "level": [80, 82],
      "ivs": 3
    })
  ]),
  "8DC67D4B6CA212": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Spiritomb",
      "pkmn": findDexEntry("Spiritomb"),
      "alpha": true,
      "level": [80, 82],
      "ivs": 4
    })
  ]),
  "5E324E1DF8EA92FB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Hippopotas",
      "pkmn": findDexEntry("Hippopotas"),
      "alpha": false,
      "level": [31, 33],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Hippopotas",
      "pkmn": findDexEntry("Hippopotas"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Hippowdon",
      "pkmn": findDexEntry("Hippowdon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Hippowdon",
      "pkmn": findDexEntry("Hippowdon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "980AC5771462B2EF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Hippowdon",
      "pkmn": findDexEntry("Hippowdon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Hippowdon",
      "pkmn": findDexEntry("Hippowdon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "980AC4771462B13C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Hippopotas",
      "pkmn": findDexEntry("Hippopotas"),
      "alpha": true,
      "level": [46, 48],
      "ivs": 4
    })
  ]),
  "980AC7771462B655": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Hippowdon",
      "pkmn": findDexEntry("Hippowdon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "30D73D9EFF1E1D08": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Skorupi",
      "pkmn": findDexEntry("Skorupi"),
      "alpha": false,
      "level": [37, 39],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Skorupi",
      "pkmn": findDexEntry("Skorupi"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Drapion",
      "pkmn": findDexEntry("Drapion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drapion",
      "pkmn": findDexEntry("Drapion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "364684B78F7D2904": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Drapion",
      "pkmn": findDexEntry("Drapion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drapion",
      "pkmn": findDexEntry("Drapion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "364685B78F7D2AB7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Skorupi",
      "pkmn": findDexEntry("Skorupi"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 4
    })
  ]),
  "364686B78F7D2C6A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Drapion",
      "pkmn": findDexEntry("Drapion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "DEB61555F04A8F1A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Croagunk",
      "pkmn": findDexEntry("Croagunk"),
      "alpha": false,
      "level": [34, 36],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Croagunk",
      "pkmn": findDexEntry("Croagunk"),
      "alpha": true,
      "level": [49, 51],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Toxicroak",
      "pkmn": findDexEntry("Toxicroak"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Toxicroak",
      "pkmn": findDexEntry("Toxicroak"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "6D7ACDBC4731F42E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Toxicroak",
      "pkmn": findDexEntry("Toxicroak"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Toxicroak",
      "pkmn": findDexEntry("Toxicroak"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "6D7ACEBC4731F5E1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Croagunk",
      "pkmn": findDexEntry("Croagunk"),
      "alpha": true,
      "level": [49, 51],
      "ivs": 4
    })
  ]),
  "6D7ACBBC4731F0C8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Toxicroak",
      "pkmn": findDexEntry("Toxicroak"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "72D67547C0638264": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Carnivine",
      "pkmn": findDexEntry("Carnivine"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Carnivine",
      "pkmn": findDexEntry("Carnivine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "C2252E31A404A568": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Carnivine",
      "pkmn": findDexEntry("Carnivine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "F59E7A06CC950E35": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Petilil",
      "pkmn": findDexEntry("Petilil"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Petilil",
      "pkmn": findDexEntry("Petilil"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Lilligant-1",
      "pkmn": findDexEntry("Lilligant"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lilligant-1",
      "pkmn": findDexEntry("Lilligant"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "1A20F2EF75D8DB19": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Lilligant-1",
      "pkmn": findDexEntry("Lilligant"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lilligant-1",
      "pkmn": findDexEntry("Lilligant"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1A20F1EF75D8D966": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Petilil",
      "pkmn": findDexEntry("Petilil"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "1A20F0EF75D8D7B3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lilligant-1",
      "pkmn": findDexEntry("Lilligant"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "EAD59441FDF5ADF8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Goomy",
      "pkmn": findDexEntry("Goomy"),
      "alpha": false,
      "level": [37, 39],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Goomy",
      "pkmn": findDexEntry("Goomy"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "C614DC641BC4FED4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "C614DD641BC50087": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Goomy",
      "pkmn": findDexEntry("Goomy"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 4
    })
  ]),
  "C614DE641BC5023A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "33920EBC10C294E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Goodra-1",
      "pkmn": findDexEntry("Goodra"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Goodra-1",
      "pkmn": findDexEntry("Goodra"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "C9316887DE23403A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Goodra-1",
      "pkmn": findDexEntry("Goodra"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Goodra-1",
      "pkmn": findDexEntry("Goodra"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "C9316987DE2341ED": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sliggoo-1",
      "pkmn": findDexEntry("Sliggoo"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "C9316687DE233CD4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Goodra-1",
      "pkmn": findDexEntry("Goodra"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "64064A0B10810230": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "90D65BF8C214FBF".parseBigInt(),
      "name": "Unown",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "9249249249248BF".parseBigInt(),
      "name": "Unown",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "1231F808B0B39880".parseBigInt(),
      "name": "Unown-01",
      "form": "01",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "124924924924917F".parseBigInt(),
      "name": "Unown-01",
      "form": "01",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "1B568A51D545E17F".parseBigInt(),
      "name": "Unown-02",
      "form": "02",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "1B6DB6DB6DB6DA80".parseBigInt(),
      "name": "Unown-02",
      "form": "02",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "247B1C9AF9D82AFF".parseBigInt(),
      "name": "Unown-03",
      "form": "03",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "24924924924922FF".parseBigInt(),
      "name": "Unown-03",
      "form": "03",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "2D9FAEE41E6A72FF".parseBigInt(),
      "name": "Unown-04",
      "form": "04",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "2DB6DB6DB6DB6D00".parseBigInt(),
      "name": "Unown-04",
      "form": "04",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "36C4412D42FCBD00".parseBigInt(),
      "name": "Unown-05",
      "form": "05",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "36DB6DB6DB6DB500".parseBigInt(),
      "name": "Unown-05",
      "form": "05",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "3FE8D376678F0500".parseBigInt(),
      "name": "Unown-06",
      "form": "06",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "3FFFFFFFFFFFFEFF".parseBigInt(),
      "name": "Unown-06",
      "form": "06",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "490D65BF8C214DFF".parseBigInt(),
      "name": "Unown-07",
      "form": "07",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "49249249249245FF".parseBigInt(),
      "name": "Unown-07",
      "form": "07",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "5231F808B0B395FF".parseBigInt(),
      "name": "Unown-08",
      "form": "08",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "5249249249249200".parseBigInt(),
      "name": "Unown-08",
      "form": "08",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "5B568A51D545E200".parseBigInt(),
      "name": "Unown-09",
      "form": "09",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "5B6DB6DB6DB6DA00".parseBigInt(),
      "name": "Unown-09",
      "form": "09",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "647B1C9AF9D82A00".parseBigInt(),
      "name": "Unown-10",
      "form": "10",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "6492492492492200".parseBigInt(),
      "name": "Unown-10",
      "form": "10",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "6D9FAEE41E6A7200".parseBigInt(),
      "name": "Unown-11",
      "form": "11",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "6DB6DB6DB6DB6A00".parseBigInt(),
      "name": "Unown-11",
      "form": "11",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "76C4412D42FCBA00".parseBigInt(),
      "name": "Unown-12",
      "form": "12",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "76DB6DB6DB6DB200".parseBigInt(),
      "name": "Unown-12",
      "form": "12",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "7FE8D376678F0200".parseBigInt(),
      "name": "Unown-13",
      "form": "13",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "7FFFFFFFFFFFFDFF".parseBigInt(),
      "name": "Unown-13",
      "form": "13",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "890D65BF8C214BFF".parseBigInt(),
      "name": "Unown-14",
      "form": "14",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "8924924924924400".parseBigInt(),
      "name": "Unown-14",
      "form": "14",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "9231F808B0B39400".parseBigInt(),
      "name": "Unown-15",
      "form": "15",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "9249249249248BFF".parseBigInt(),
      "name": "Unown-15",
      "form": "15",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "9B568A51D545DBFF".parseBigInt(),
      "name": "Unown-16",
      "form": "16",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "9B6DB6DB6DB6DBFF".parseBigInt(),
      "name": "Unown-16",
      "form": "16",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "A47B1C9AF9D82BFF".parseBigInt(),
      "name": "Unown-17",
      "form": "17",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "A492492492492400".parseBigInt(),
      "name": "Unown-17",
      "form": "17",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "AD9FAEE41E6A7400".parseBigInt(),
      "name": "Unown-18",
      "form": "18",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "ADB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Unown-18",
      "form": "18",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "B6C4412D42FCBBFF".parseBigInt(),
      "name": "Unown-19",
      "form": "19",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "B6DB6DB6DB6DB400".parseBigInt(),
      "name": "Unown-19",
      "form": "19",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "BFE8D376678F0400".parseBigInt(),
      "name": "Unown-20",
      "form": "20",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "BFFFFFFFFFFFFBFF".parseBigInt(),
      "name": "Unown-20",
      "form": "20",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "C90D65BF8C214BFF".parseBigInt(),
      "name": "Unown-21",
      "form": "21",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "C924924924924400".parseBigInt(),
      "name": "Unown-21",
      "form": "21",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "D231F808B0B39400".parseBigInt(),
      "name": "Unown-22",
      "form": "22",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "D249249249248BFF".parseBigInt(),
      "name": "Unown-22",
      "form": "22",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "DB568A51D545DBFF".parseBigInt(),
      "name": "Unown-23",
      "form": "23",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "DB6DB6DB6DB6D400".parseBigInt(),
      "name": "Unown-23",
      "form": "23",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "E47B1C9AF9D82400".parseBigInt(),
      "name": "Unown-24",
      "form": "24",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Unown-24",
      "form": "24",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "ED9FAEE41E6A6BFF".parseBigInt(),
      "name": "Unown-25",
      "form": "25",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "EDB6DB6DB6DB6400".parseBigInt(),
      "name": "Unown-25",
      "form": "25",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "F6C4412D42FCB400".parseBigInt(),
      "name": "Unown-26",
      "form": "26",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "F6DB6DB6DB6DB400".parseBigInt(),
      "name": "Unown-26",
      "form": "26",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFE8D376678F0400".parseBigInt(),
      "name": "Unown-27",
      "form": "27",
      "pkmn": findDexEntry("Unown"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Unown-27",
      "form": "27",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "D3FB11A4B88400FC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "9249249249248BF".parseBigInt(),
      "name": "Unown",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "124924924924917F".parseBigInt(),
      "name": "Unown-01",
      "form": "01",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "1B6DB6DB6DB6DA80".parseBigInt(),
      "name": "Unown-02",
      "form": "02",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "24924924924922FF".parseBigInt(),
      "name": "Unown-03",
      "form": "03",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "2DB6DB6DB6DB6D00".parseBigInt(),
      "name": "Unown-04",
      "form": "04",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "36DB6DB6DB6DB500".parseBigInt(),
      "name": "Unown-05",
      "form": "05",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "3FFFFFFFFFFFFEFF".parseBigInt(),
      "name": "Unown-06",
      "form": "06",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "49249249249245FF".parseBigInt(),
      "name": "Unown-07",
      "form": "07",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "5249249249249200".parseBigInt(),
      "name": "Unown-08",
      "form": "08",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "5B6DB6DB6DB6DA00".parseBigInt(),
      "name": "Unown-09",
      "form": "09",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "6492492492492200".parseBigInt(),
      "name": "Unown-10",
      "form": "10",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "6DB6DB6DB6DB6A00".parseBigInt(),
      "name": "Unown-11",
      "form": "11",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "76DB6DB6DB6DB200".parseBigInt(),
      "name": "Unown-12",
      "form": "12",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "7FFFFFFFFFFFFDFF".parseBigInt(),
      "name": "Unown-13",
      "form": "13",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "8924924924924400".parseBigInt(),
      "name": "Unown-14",
      "form": "14",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "9249249249248BFF".parseBigInt(),
      "name": "Unown-15",
      "form": "15",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "9B6DB6DB6DB6DBFF".parseBigInt(),
      "name": "Unown-16",
      "form": "16",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "A492492492492400".parseBigInt(),
      "name": "Unown-17",
      "form": "17",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "ADB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Unown-18",
      "form": "18",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "B6DB6DB6DB6DB400".parseBigInt(),
      "name": "Unown-19",
      "form": "19",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "BFFFFFFFFFFFFBFF".parseBigInt(),
      "name": "Unown-20",
      "form": "20",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "C924924924924400".parseBigInt(),
      "name": "Unown-21",
      "form": "21",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "D249249249248BFF".parseBigInt(),
      "name": "Unown-22",
      "form": "22",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "DB6DB6DB6DB6D400".parseBigInt(),
      "name": "Unown-23",
      "form": "23",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Unown-24",
      "form": "24",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "EDB6DB6DB6DB6400".parseBigInt(),
      "name": "Unown-25",
      "form": "25",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "F6DB6DB6DB6DB400".parseBigInt(),
      "name": "Unown-26",
      "form": "26",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Unown-27",
      "form": "27",
      "pkmn": findDexEntry("Unown"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "6F03E1A52F7D3223": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Vulpix",
      "pkmn": findDexEntry("Vulpix"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Vulpix",
      "pkmn": findDexEntry("Vulpix"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Ninetales",
      "pkmn": findDexEntry("Ninetales"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ninetales",
      "pkmn": findDexEntry("Ninetales"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "1493F986C11EAC67": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Ninetales",
      "pkmn": findDexEntry("Ninetales"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ninetales",
      "pkmn": findDexEntry("Ninetales"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1493F886C11EAAB4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Vulpix",
      "pkmn": findDexEntry("Vulpix"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "1493FB86C11EAFCD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ninetales",
      "pkmn": findDexEntry("Ninetales"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "F952ECA9545BE7A3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Growlithe-1",
      "pkmn": findDexEntry("Growlithe"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Growlithe-1",
      "pkmn": findDexEntry("Growlithe"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Arcanine-1",
      "pkmn": findDexEntry("Arcanine"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Arcanine-1",
      "pkmn": findDexEntry("Arcanine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "9EE3048AE5FD61E7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Arcanine-1",
      "pkmn": findDexEntry("Arcanine"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Arcanine-1",
      "pkmn": findDexEntry("Arcanine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "9EE3038AE5FD6034": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Growlithe-1",
      "pkmn": findDexEntry("Growlithe"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "9EE3068AE5FD654D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Arcanine-1",
      "pkmn": findDexEntry("Arcanine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "C44A139615D5807E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Machop",
      "pkmn": findDexEntry("Machop"),
      "alpha": false,
      "level": [25, 27],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Machop",
      "pkmn": findDexEntry("Machop"),
      "alpha": true,
      "level": [40, 42],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "88BE9C3CF8EBCC0A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "88BE9D3CF8EBCDBD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machop",
      "pkmn": findDexEntry("Machop"),
      "alpha": true,
      "level": [40, 42],
      "ivs": 4
    })
  ]),
  "88BE9A3CF8EBC8A4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "FDE94940751B7D08": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Machamp",
      "pkmn": findDexEntry("Machamp"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machamp",
      "pkmn": findDexEntry("Machamp"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "3589059057A8904": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Machamp",
      "pkmn": findDexEntry("Machamp"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machamp",
      "pkmn": findDexEntry("Machamp"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "3589159057A8AB7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machoke",
      "pkmn": findDexEntry("Machoke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "3589259057A8C6A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Machamp",
      "pkmn": findDexEntry("Machamp"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "A6D0B804DEC5D165": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Tentacool",
      "pkmn": findDexEntry("Tentacool"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Tentacool",
      "pkmn": findDexEntry("Tentacool"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Tentacruel",
      "pkmn": findDexEntry("Tentacruel"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tentacruel",
      "pkmn": findDexEntry("Tentacruel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "4BF42FE6700B1CE9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Tentacruel",
      "pkmn": findDexEntry("Tentacruel"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tentacruel",
      "pkmn": findDexEntry("Tentacruel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "4BF42EE6700B1B36": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tentacool",
      "pkmn": findDexEntry("Tentacool"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "4BF42DE6700B1983": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Tentacruel",
      "pkmn": findDexEntry("Tentacruel"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "E5BEFD02102232EA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Blissey",
      "pkmn": findDexEntry("Blissey"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Blissey",
      "pkmn": findDexEntry("Blissey"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "214A745B2D0BE75E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Blissey",
      "pkmn": findDexEntry("Blissey"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Blissey",
      "pkmn": findDexEntry("Blissey"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "214A755B2D0BE911": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "214A725B2D0BE3F8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Blissey",
      "pkmn": findDexEntry("Blissey"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "5CB29387A22D4AFA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Magmortar",
      "pkmn": findDexEntry("Magmortar"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmortar",
      "pkmn": findDexEntry("Magmortar"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "96BA4BEB8516340E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Magmortar",
      "pkmn": findDexEntry("Magmortar"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmortar",
      "pkmn": findDexEntry("Magmortar"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "96BA4CEB851635C1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "96BA49EB851630A8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmortar",
      "pkmn": findDexEntry("Magmortar"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "ABF467237487BF28": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Magikarp",
      "pkmn": findDexEntry("Magikarp"),
      "alpha": false,
      "level": [17, 19],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Magikarp",
      "pkmn": findDexEntry("Magikarp"),
      "alpha": true,
      "level": [32, 34],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gyarados",
      "pkmn": findDexEntry("Gyarados"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gyarados",
      "pkmn": findDexEntry("Gyarados"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "5CA5AE3990E69C24": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gyarados",
      "pkmn": findDexEntry("Gyarados"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gyarados",
      "pkmn": findDexEntry("Gyarados"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "5CA5AF3990E69DD7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magikarp",
      "pkmn": findDexEntry("Magikarp"),
      "alpha": true,
      "level": [32, 34],
      "ivs": 4
    })
  ]),
  "5CA5B03990E69F8A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gyarados",
      "pkmn": findDexEntry("Gyarados"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "A9B9415FFACD90C4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Cleffa",
      "pkmn": findDexEntry("Cleffa"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Cleffa",
      "pkmn": findDexEntry("Cleffa"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "4DC4FA4C526D2FC8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "4DC4FB4C526D317B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Cleffa",
      "pkmn": findDexEntry("Cleffa"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "4DC4FC4C526D332E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "13E5616E29422F7A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Togepi",
      "pkmn": findDexEntry("Togepi"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Togepi",
      "pkmn": findDexEntry("Togepi"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "4DED19D20C2B188E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "4DED1AD20C2B1A41": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togepi",
      "pkmn": findDexEntry("Togepi"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "4DED17D20C2B1528": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "359B53CAD9D52791": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Togekiss",
      "pkmn": findDexEntry("Togekiss"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togekiss",
      "pkmn": findDexEntry("Togekiss"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "FA0FDC71BCEB731D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Togekiss",
      "pkmn": findDexEntry("Togekiss"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togekiss",
      "pkmn": findDexEntry("Togekiss"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "FA0FDB71BCEB716A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togetic",
      "pkmn": findDexEntry("Togetic"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "FA0FDA71BCEB6FB7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Togekiss",
      "pkmn": findDexEntry("Togekiss"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1303244B4F700044": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Aipom",
      "pkmn": findDexEntry("Aipom"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Aipom",
      "pkmn": findDexEntry("Aipom"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Ambipom",
      "pkmn": findDexEntry("Ambipom"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ambipom",
      "pkmn": findDexEntry("Ambipom"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "B70EDD37A70F9F48": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Ambipom",
      "pkmn": findDexEntry("Ambipom"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ambipom",
      "pkmn": findDexEntry("Ambipom"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B70EDE37A70FA0FB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Aipom",
      "pkmn": findDexEntry("Aipom"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "B70EDF37A70FA2AE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ambipom",
      "pkmn": findDexEntry("Ambipom"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "C36D985994A653F4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Qwilfish-1",
      "pkmn": findDexEntry("Qwilfish"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Qwilfish-1",
      "pkmn": findDexEntry("Qwilfish"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Overqwil",
      "pkmn": findDexEntry("Overqwil"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Overqwil",
      "pkmn": findDexEntry("Overqwil"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "3E9E5039EC471398": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Overqwil",
      "pkmn": findDexEntry("Overqwil"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Overqwil",
      "pkmn": findDexEntry("Overqwil"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "3E9E5139EC47154B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Qwilfish-1",
      "pkmn": findDexEntry("Qwilfish"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "3E9E5239EC4716FE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Overqwil",
      "pkmn": findDexEntry("Overqwil"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "8A464B6EE75BFD4C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Magby",
      "pkmn": findDexEntry("Magby"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Magby",
      "pkmn": findDexEntry("Magby"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "C56542C803E9B960": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "C56543C803E9BB13": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magby",
      "pkmn": findDexEntry("Magby"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "C56544C803E9BCC6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Magmar",
      "pkmn": findDexEntry("Magmar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "7019147A364CBDE3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": false,
      "level": [41, 43],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": true,
      "level": [56, 58],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Walrein",
      "pkmn": findDexEntry("Walrein"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Walrein",
      "pkmn": findDexEntry("Walrein"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "6C2E2C56DFEF8D27": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Walrein",
      "pkmn": findDexEntry("Walrein"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Walrein",
      "pkmn": findDexEntry("Walrein"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "6C2E2B56DFEF8B74": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sealeo",
      "pkmn": findDexEntry("Sealeo"),
      "alpha": true,
      "level": [56, 58],
      "ivs": 4
    })
  ]),
  "6C2E2E56DFEF908D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Walrein",
      "pkmn": findDexEntry("Walrein"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "D50704A9B3BC059C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Piplup",
      "pkmn": findDexEntry("Piplup"),
      "alpha": false,
      "level": [13, 15],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Piplup",
      "pkmn": findDexEntry("Piplup"),
      "alpha": true,
      "level": [28, 30],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    })
  ]),
  "EA1BD0D96481CD0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "EA1BE0D96481E83": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Piplup",
      "pkmn": findDexEntry("Piplup"),
      "alpha": true,
      "level": [28, 30],
      "ivs": 4
    })
  ]),
  "EA1BF0D96482036": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "7BDDFF2CB7692BB4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Empoleon",
      "pkmn": findDexEntry("Empoleon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Empoleon",
      "pkmn": findDexEntry("Empoleon"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "4D93B708270B4058": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Empoleon",
      "pkmn": findDexEntry("Empoleon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Empoleon",
      "pkmn": findDexEntry("Empoleon"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "4D93B808270B420B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Prinplup",
      "pkmn": findDexEntry("Prinplup"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "4D93B908270B43BE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Empoleon",
      "pkmn": findDexEntry("Empoleon"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "1D5825AF90B533C6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Glameow",
      "pkmn": findDexEntry("Glameow"),
      "alpha": false,
      "level": [35, 37],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Glameow",
      "pkmn": findDexEntry("Glameow"),
      "alpha": true,
      "level": [50, 52],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Purugly",
      "pkmn": findDexEntry("Purugly"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Purugly",
      "pkmn": findDexEntry("Purugly"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "22C76CC821143FC2": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Purugly",
      "pkmn": findDexEntry("Purugly"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Purugly",
      "pkmn": findDexEntry("Purugly"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "22C76DC821144175": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Glameow",
      "pkmn": findDexEntry("Glameow"),
      "alpha": true,
      "level": [50, 52],
      "ivs": 4
    })
  ]),
  "22C76AC821143C5C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Purugly",
      "pkmn": findDexEntry("Purugly"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "4625E3DAEE7FBCA3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Happiny",
      "pkmn": findDexEntry("Happiny"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Happiny",
      "pkmn": findDexEntry("Happiny"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "EBB5FBBC802136E7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "EBB5FABC80213534": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Happiny",
      "pkmn": findDexEntry("Happiny"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "EBB5FDBC80213A4D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chansey",
      "pkmn": findDexEntry("Chansey"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "5FD7B5386E4E8864": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Riolu",
      "pkmn": findDexEntry("Riolu"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Riolu",
      "pkmn": findDexEntry("Riolu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Lucario",
      "pkmn": findDexEntry("Lucario"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lucario",
      "pkmn": findDexEntry("Lucario"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "AF266E2251EFAB68": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Lucario",
      "pkmn": findDexEntry("Lucario"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lucario",
      "pkmn": findDexEntry("Lucario"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "AF266F2251EFAD1B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Riolu",
      "pkmn": findDexEntry("Riolu"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "AF26702251EFAECE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lucario",
      "pkmn": findDexEntry("Lucario"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "A043B85457FB671F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Finneon",
      "pkmn": findDexEntry("Finneon"),
      "alpha": false,
      "level": [28, 30],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Finneon",
      "pkmn": findDexEntry("Finneon"),
      "alpha": true,
      "level": [43, 45],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Lumineon",
      "pkmn": findDexEntry("Lumineon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lumineon",
      "pkmn": findDexEntry("Lumineon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "3BDD3FEF3B12D34B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Lumineon",
      "pkmn": findDexEntry("Lumineon"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lumineon",
      "pkmn": findDexEntry("Lumineon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "3BDD3EEF3B12D198": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Finneon",
      "pkmn": findDexEntry("Finneon"),
      "alpha": true,
      "level": [43, 45],
      "ivs": 4
    })
  ]),
  "3BDD41EF3B12D6B1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Lumineon",
      "pkmn": findDexEntry("Lumineon"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1FE5B66F00A81D14": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Mantyke",
      "pkmn": findDexEntry("Mantyke"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Mantyke",
      "pkmn": findDexEntry("Mantyke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Mantine",
      "pkmn": findDexEntry("Mantine"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mantine",
      "pkmn": findDexEntry("Mantine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "44A66E4CE2D8CC38": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Mantine",
      "pkmn": findDexEntry("Mantine"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mantine",
      "pkmn": findDexEntry("Mantine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "44A66F4CE2D8CDEB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mantyke",
      "pkmn": findDexEntry("Mantyke"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "44A6704CE2D8CF9E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mantine",
      "pkmn": findDexEntry("Mantine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "A37B2DA46ABBE8A6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "D0214D0214D01BFF".parseBigInt(),
      "name": "Basculin-2",
      "pkmn": findDexEntry("Basculin"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "D2361D2361D23400".parseBigInt(),
      "name": "Basculin-2",
      "pkmn": findDexEntry("Basculin"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "E7063E7063E70400".parseBigInt(),
      "name": "Basculegion",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FBD65FBD65FBD400".parseBigInt(),
      "name": "Basculegion-1",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FDEB2FDEB2FDE400".parseBigInt(),
      "name": "Basculegion",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Basculegion-1",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "542CF4BA871B9F22": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "7EBB9079A9D25DFF".parseBigInt(),
      "name": "Basculegion",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Basculegion-1",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FEBB9079A9D25BFF".parseBigInt(),
      "name": "Basculegion",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Basculegion-1",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "542CF5BA871BA0D5": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Basculin-2",
      "pkmn": findDexEntry("Basculin"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "542CF2BA871B9BBC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "7FFFFFFFFFFFFDFF".parseBigInt(),
      "name": "Basculegion",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Basculegion-1",
      "pkmn": findDexEntry("Basculegion"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "11E3B0315A9DB8B1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Clefable",
      "pkmn": findDexEntry("Clefable"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefable",
      "pkmn": findDexEntry("Clefable"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "D65838D83DB4043D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Clefable",
      "pkmn": findDexEntry("Clefable"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefable",
      "pkmn": findDexEntry("Clefable"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "D65837D83DB4028A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefairy",
      "pkmn": findDexEntry("Clefairy"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "D65836D83DB400D7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Clefable",
      "pkmn": findDexEntry("Clefable"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "74F99006BF1DF995": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Voltorb-1",
      "pkmn": findDexEntry("Voltorb"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Voltorb-1",
      "pkmn": findDexEntry("Voltorb"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Electrode-1",
      "pkmn": findDexEntry("Electrode"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electrode-1",
      "pkmn": findDexEntry("Electrode"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "997C88EF68629FF9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Electrode-1",
      "pkmn": findDexEntry("Electrode"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electrode-1",
      "pkmn": findDexEntry("Electrode"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "997C87EF68629E46": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Voltorb-1",
      "pkmn": findDexEntry("Voltorb"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "997C86EF68629C93": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electrode-1",
      "pkmn": findDexEntry("Electrode"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "7E6885E452C04311": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Electivire",
      "pkmn": findDexEntry("Electivire"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electivire",
      "pkmn": findDexEntry("Electivire"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "42DD0E8B35D68E9D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Electivire",
      "pkmn": findDexEntry("Electivire"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electivire",
      "pkmn": findDexEntry("Electivire"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "42DD0D8B35D68CEA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "42DD0C8B35D68B37": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electivire",
      "pkmn": findDexEntry("Electivire"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "3B40EB53F427739": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Misdreavus",
      "pkmn": findDexEntry("Misdreavus"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Misdreavus",
      "pkmn": findDexEntry("Misdreavus"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Mismagius",
      "pkmn": findDexEntry("Mismagius"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mismagius",
      "pkmn": findDexEntry("Mismagius"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "DF3115CC95FDD0D5": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Mismagius",
      "pkmn": findDexEntry("Mismagius"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mismagius",
      "pkmn": findDexEntry("Mismagius"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "DF3114CC95FDCF22": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Misdreavus",
      "pkmn": findDexEntry("Misdreavus"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "DF3113CC95FDCD6F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mismagius",
      "pkmn": findDexEntry("Mismagius"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B549ADD0FBB4E11E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Gligar",
      "pkmn": findDexEntry("Gligar"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Gligar",
      "pkmn": findDexEntry("Gligar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gliscor",
      "pkmn": findDexEntry("Gliscor"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gliscor",
      "pkmn": findDexEntry("Gliscor"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "79BE3677DECB2CAA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gliscor",
      "pkmn": findDexEntry("Gliscor"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gliscor",
      "pkmn": findDexEntry("Gliscor"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "79BE3777DECB2E5D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gligar",
      "pkmn": findDexEntry("Gligar"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "79BE3477DECB2944": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gliscor",
      "pkmn": findDexEntry("Gliscor"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "43F1F75C8859C78E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Heracross",
      "pkmn": findDexEntry("Heracross"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Heracross",
      "pkmn": findDexEntry("Heracross"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "9EA3EF8A570DE7A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Heracross",
      "pkmn": findDexEntry("Heracross"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "7C1EF5BAB066B858": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Sneasel-1",
      "pkmn": findDexEntry("Sneasel"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Sneasel-1",
      "pkmn": findDexEntry("Sneasel"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Sneasler",
      "pkmn": findDexEntry("Sneasler"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sneasler",
      "pkmn": findDexEntry("Sneasler"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "AA693DDF40C4A3B4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Sneasler",
      "pkmn": findDexEntry("Sneasler"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sneasler",
      "pkmn": findDexEntry("Sneasler"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "AA693EDF40C4A567": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sneasel-1",
      "pkmn": findDexEntry("Sneasel"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "AA693FDF40C4A71A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Sneasler",
      "pkmn": findDexEntry("Sneasler"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "2BE4440F60B027BC": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Elekid",
      "pkmn": findDexEntry("Elekid"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Elekid",
      "pkmn": findDexEntry("Elekid"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "12747C70D0AE7DF0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "12747D70D0AE7FA3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Elekid",
      "pkmn": findDexEntry("Elekid"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "12747E70D0AE8156": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Electabuzz",
      "pkmn": findDexEntry("Electabuzz"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "535CFB0C132AFE2B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Nosepass",
      "pkmn": findDexEntry("Nosepass"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Nosepass",
      "pkmn": findDexEntry("Nosepass"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Probopass",
      "pkmn": findDexEntry("Probopass"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Probopass",
      "pkmn": findDexEntry("Probopass"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "B975F37131844CFF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Probopass",
      "pkmn": findDexEntry("Probopass"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Probopass",
      "pkmn": findDexEntry("Probopass"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "B975F27131844B4C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Nosepass",
      "pkmn": findDexEntry("Nosepass"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "B975F57131845065": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Probopass",
      "pkmn": findDexEntry("Probopass"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "38865A58581A125B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Duskull",
      "pkmn": findDexEntry("Duskull"),
      "alpha": false,
      "level": [34, 36],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Duskull",
      "pkmn": findDexEntry("Duskull"),
      "alpha": true,
      "level": [49, 51],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    })
  ]),
  "7411D1B17503C6CF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "7411D0B17503C51C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Duskull",
      "pkmn": findDexEntry("Duskull"),
      "alpha": true,
      "level": [49, 51],
      "ivs": 4
    })
  ]),
  "7411D3B17503CA35": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "719AB319152CAC75": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Dusknoir",
      "pkmn": findDexEntry("Dusknoir"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusknoir",
      "pkmn": findDexEntry("Dusknoir"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "961D2C01BE707959": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Dusknoir",
      "pkmn": findDexEntry("Dusknoir"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusknoir",
      "pkmn": findDexEntry("Dusknoir"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "961D2B01BE7077A6": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusclops",
      "pkmn": findDexEntry("Dusclops"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "961D2A01BE7075F3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dusknoir",
      "pkmn": findDexEntry("Dusknoir"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "1F583F5782609CBD": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Chingling",
      "pkmn": findDexEntry("Chingling"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Chingling",
      "pkmn": findDexEntry("Chingling"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Chimecho",
      "pkmn": findDexEntry("Chimecho"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chimecho",
      "pkmn": findDexEntry("Chimecho"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "5AE3B6B09F4A5131": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Chimecho",
      "pkmn": findDexEntry("Chimecho"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chimecho",
      "pkmn": findDexEntry("Chimecho"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "5AE3B5B09F4A4F7E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chingling",
      "pkmn": findDexEntry("Chingling"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "5AE3B4B09F4A4DCB": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Chimecho",
      "pkmn": findDexEntry("Chimecho"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "1DD87D8FAD092308": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Gible",
      "pkmn": findDexEntry("Gible"),
      "alpha": false,
      "level": [21, 23],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Gible",
      "pkmn": findDexEntry("Gible"),
      "alpha": true,
      "level": [36, 38],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": false,
      "level": [45, 47],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": true,
      "level": [60, 62],
      "ivs": 3
    })
  ]),
  "2347C4A83D682F04": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": false,
      "level": [45, 47],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": true,
      "level": [60, 62],
      "ivs": 4
    })
  ]),
  "2347C5A83D6830B7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gible",
      "pkmn": findDexEntry("Gible"),
      "alpha": true,
      "level": [36, 38],
      "ivs": 4
    })
  ]),
  "2347C6A83D68326A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": true,
      "level": [60, 62],
      "ivs": 4
    })
  ]),
  "85714105CF348588": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": false,
      "level": [45, 47],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": true,
      "level": [60, 62],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Garchomp",
      "pkmn": findDexEntry("Garchomp"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Garchomp",
      "pkmn": findDexEntry("Garchomp"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "8AE0881E5F939184": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Garchomp",
      "pkmn": findDexEntry("Garchomp"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Garchomp",
      "pkmn": findDexEntry("Garchomp"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "8AE0891E5F939337": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gabite",
      "pkmn": findDexEntry("Gabite"),
      "alpha": true,
      "level": [60, 62],
      "ivs": 4
    })
  ]),
  "8AE08A1E5F9394EA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Garchomp",
      "pkmn": findDexEntry("Garchomp"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "1F9587A4771A0D70": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Snover",
      "pkmn": findDexEntry("Snover"),
      "alpha": false,
      "level": [37, 39],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Snover",
      "pkmn": findDexEntry("Snover"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Abomasnow",
      "pkmn": findDexEntry("Abomasnow"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Abomasnow",
      "pkmn": findDexEntry("Abomasnow"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "39054F43071BB73C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Abomasnow",
      "pkmn": findDexEntry("Abomasnow"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Abomasnow",
      "pkmn": findDexEntry("Abomasnow"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "39055043071BB8EF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Snover",
      "pkmn": findDexEntry("Snover"),
      "alpha": true,
      "level": [52, 54],
      "ivs": 4
    })
  ]),
  "39055143071BBAA2": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Abomasnow",
      "pkmn": findDexEntry("Abomasnow"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "72AFB1813E05C033": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Rotom",
      "pkmn": findDexEntry("Rotom"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rotom",
      "pkmn": findDexEntry("Rotom"),
      "alpha": true,
      "level": [80, 82],
      "ivs": 3
    })
  ]),
  "979F4A69E7A69557": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rotom",
      "pkmn": findDexEntry("Rotom"),
      "alpha": true,
      "level": [80, 82],
      "ivs": 4
    })
  ]),
  "5EB6A79B1B1FFB18": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Rowlet",
      "pkmn": findDexEntry("Rowlet"),
      "alpha": false,
      "level": [14, 16],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Rowlet",
      "pkmn": findDexEntry("Rowlet"),
      "alpha": true,
      "level": [29, 31],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    })
  ]),
  "E385EFBAC37F3B74": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "E385F0BAC37F3D27": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rowlet",
      "pkmn": findDexEntry("Rowlet"),
      "alpha": true,
      "level": [29, 31],
      "ivs": 4
    })
  ]),
  "E385F1BAC37F3EDA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "65503545DDDA60FA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Decidueye-1",
      "pkmn": findDexEntry("Decidueye"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Decidueye-1",
      "pkmn": findDexEntry("Decidueye"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "9F57EDA9C0C34A0E": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Decidueye-1",
      "pkmn": findDexEntry("Decidueye"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Decidueye-1",
      "pkmn": findDexEntry("Decidueye"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "9F57EEA9C0C34BC1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dartrix",
      "pkmn": findDexEntry("Dartrix"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "9F57EBA9C0C346A8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Decidueye-1",
      "pkmn": findDexEntry("Decidueye"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "5D27A6CE8F149ABA": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": false,
      "level": [60, 62],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Mamoswine",
      "pkmn": findDexEntry("Mamoswine"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mamoswine",
      "pkmn": findDexEntry("Mamoswine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "972F5F3271FD83CE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Mamoswine",
      "pkmn": findDexEntry("Mamoswine"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mamoswine",
      "pkmn": findDexEntry("Mamoswine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "972F603271FD8581": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Piloswine",
      "pkmn": findDexEntry("Piloswine"),
      "alpha": true,
      "level": [75, 77],
      "ivs": 4
    })
  ]),
  "972F5D3271FD8068": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Mamoswine",
      "pkmn": findDexEntry("Mamoswine"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "225AB5796A9B35A8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Ralts",
      "pkmn": findDexEntry("Ralts"),
      "alpha": false,
      "level": [17, 19],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Ralts",
      "pkmn": findDexEntry("Ralts"),
      "alpha": true,
      "level": [32, 34],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    })
  ]),
  "D30BFC8F86FA12A4": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "D30BFD8F86FA1457": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Ralts",
      "pkmn": findDexEntry("Ralts"),
      "alpha": true,
      "level": [32, 34],
      "ivs": 4
    })
  ]),
  "D30BFE8F86FA160A": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "11EF632709A94392": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gardevoir",
      "pkmn": findDexEntry("Gardevoir"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gardevoir",
      "pkmn": findDexEntry("Gardevoir"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "38631B04ED4B8736": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gardevoir",
      "pkmn": findDexEntry("Gardevoir"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gardevoir",
      "pkmn": findDexEntry("Gardevoir"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "38631C04ED4B88E9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "38631904ED4B83D0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gardevoir",
      "pkmn": findDexEntry("Gardevoir"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "2C5861D521AA1336": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": false,
      "level": [27, 29],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Gallade",
      "pkmn": findDexEntry("Gallade"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gallade",
      "pkmn": findDexEntry("Gallade"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "5E4A9F73E07CF92": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Gallade",
      "pkmn": findDexEntry("Gallade"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gallade",
      "pkmn": findDexEntry("Gallade"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "5E4AAF73E07D145": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Kirlia",
      "pkmn": findDexEntry("Kirlia"),
      "alpha": true,
      "level": [42, 44],
      "ivs": 4
    })
  ]),
  "5E4A7F73E07CC2C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Gallade",
      "pkmn": findDexEntry("Gallade"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "920D11DAB8D7B9C7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Snorunt",
      "pkmn": findDexEntry("Snorunt"),
      "alpha": false,
      "level": [39, 41],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Snorunt",
      "pkmn": findDexEntry("Snorunt"),
      "alpha": true,
      "level": [54, 56],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Glalie",
      "pkmn": findDexEntry("Glalie"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Glalie",
      "pkmn": findDexEntry("Glalie"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "97AB79FE10A75883": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Glalie",
      "pkmn": findDexEntry("Glalie"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Glalie",
      "pkmn": findDexEntry("Glalie"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "97AB78FE10A756D0": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Snorunt",
      "pkmn": findDexEntry("Snorunt"),
      "alpha": true,
      "level": [54, 56],
      "ivs": 4
    })
  ]),
  "97AB7BFE10A75BE9": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Glalie",
      "pkmn": findDexEntry("Glalie"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "EFC729C7F6FE3183": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Snorunt",
      "pkmn": findDexEntry("Snorunt"),
      "alpha": false,
      "level": [39, 41],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Snorunt",
      "pkmn": findDexEntry("Snorunt"),
      "alpha": true,
      "level": [54, 56],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Froslass",
      "pkmn": findDexEntry("Froslass"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Froslass",
      "pkmn": findDexEntry("Froslass"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "EA28C1A49F2E92C7": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Froslass",
      "pkmn": findDexEntry("Froslass"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Froslass",
      "pkmn": findDexEntry("Froslass"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "EA28C0A49F2E9114": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Snorunt",
      "pkmn": findDexEntry("Snorunt"),
      "alpha": true,
      "level": [54, 56],
      "ivs": 4
    })
  ]),
  "EA28C3A49F2E962D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Froslass",
      "pkmn": findDexEntry("Froslass"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "433A2D3EF14D5E5F": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Oshawott",
      "pkmn": findDexEntry("Oshawott"),
      "alpha": false,
      "level": [14, 16],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Oshawott",
      "pkmn": findDexEntry("Oshawott"),
      "alpha": true,
      "level": [29, 31],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    })
  ]),
  "DED3B4D9D464CA8B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "DED3B3D9D464C8D8": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Oshawott",
      "pkmn": findDexEntry("Oshawott"),
      "alpha": true,
      "level": [29, 31],
      "ivs": 4
    })
  ]),
  "DED3B6D9D464CDF1": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "23AD04E3DF914A0B": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": false,
      "level": [33, 35],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Samurott-1",
      "pkmn": findDexEntry("Samurott"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Samurott-1",
      "pkmn": findDexEntry("Samurott"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 3
    })
  ]),
  "88137D48FC79DDDF": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Samurott-1",
      "pkmn": findDexEntry("Samurott"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Samurott-1",
      "pkmn": findDexEntry("Samurott"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "88137C48FC79DC2C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Dewott",
      "pkmn": findDexEntry("Dewott"),
      "alpha": true,
      "level": [48, 50],
      "ivs": 4
    })
  ]),
  "88137F48FC79E145": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Samurott-1",
      "pkmn": findDexEntry("Samurott"),
      "alpha": true,
      "level": [82, 84],
      "ivs": 4
    })
  ]),
  "EC7666812A3AC3C3": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Rufflet",
      "pkmn": findDexEntry("Rufflet"),
      "alpha": false,
      "level": [51, 53],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Rufflet",
      "pkmn": findDexEntry("Rufflet"),
      "alpha": true,
      "level": [66, 68],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Braviary-1",
      "pkmn": findDexEntry("Braviary"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Braviary-1",
      "pkmn": findDexEntry("Braviary"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "9052FE62BA69D007": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Braviary-1",
      "pkmn": findDexEntry("Braviary"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Braviary-1",
      "pkmn": findDexEntry("Braviary"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "9052FD62BA69CE54": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Rufflet",
      "pkmn": findDexEntry("Rufflet"),
      "alpha": true,
      "level": [66, 68],
      "ivs": 4
    })
  ]),
  "90530062BA69D36D": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Braviary-1",
      "pkmn": findDexEntry("Braviary"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "ECBF77B8F7302126": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "E492492492491BFF".parseBigInt(),
      "name": "Bergmite",
      "pkmn": findDexEntry("Bergmite"),
      "alpha": false,
      "level": [34, 36],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "E6DB6DB6DB6DB400".parseBigInt(),
      "name": "Bergmite",
      "pkmn": findDexEntry("Bergmite"),
      "alpha": true,
      "level": [49, 51],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FDB6DB6DB6DB6BFF".parseBigInt(),
      "name": "Avalugg-1",
      "pkmn": findDexEntry("Avalugg"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Avalugg-1",
      "pkmn": findDexEntry("Avalugg"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 3
    })
  ]),
  "9D713ECF138FD7A2": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Avalugg-1",
      "pkmn": findDexEntry("Avalugg"),
      "alpha": false,
      "level": [62, 64],
      "ivs": 3
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Avalugg-1",
      "pkmn": findDexEntry("Avalugg"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "9D713FCF138FD955": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Bergmite",
      "pkmn": findDexEntry("Bergmite"),
      "alpha": true,
      "level": [49, 51],
      "ivs": 4
    })
  ]),
  "9D713CCF138FD43C": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Avalugg-1",
      "pkmn": findDexEntry("Avalugg"),
      "alpha": true,
      "level": [77, 79],
      "ivs": 4
    })
  ]),
  "EEFEE": EncounterTable([
    EncounterSlot.fromMap({
      "slot": "FD7720F353A4BBFF".parseBigInt(),
      "name": "Eevee",
      "pkmn": findDexEntry("Eevee"),
      "alpha": false,
      "level": [15, 16],
      "ivs": 0
    }),
    EncounterSlot.fromMap({
      "slot": "FFFFFFFFFFFFFFFF".parseBigInt(),
      "name": "Eevee",
      "pkmn": findDexEntry("Eevee"),
      "alpha": true,
      "level": [30, 31],
      "ivs": 3
    })
  ])
};

PokedexEntry findDexEntry(String name) {
  return pokedex.values.firstWhere((element) => element.pokemon == name, orElse: () => PokedexEntry('NULL($name)', -1, 0));
}

void main(List<String> args) {
  var enc = encounterSlotsMap["64064A0B10810230"]!;
  var rng = XOROSHIROLite();

  for (var i = 0; i < 10; i++) {
    var num = rng.next();
    enc.findSlot(num);
  }
}