import 'dart:io';

import 'package:mmo_searcher/mass_outbreak/search/model/filters.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/mass_outbreak/search/utils/num.dart';
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

import '../../../nxreader.dart';

var _debug = false;
void debug(dynamic v) {
  if (_debug) {
    print(v);
  }
}

class MassOutbreakSearcherService implements MassOutbreakSearcher {
  @override
  Future<MassOutbreakInformation> getMassOutbreakInformation() async {
    var reader = NxReader("192.168.0.10");
    await reader.connect();
    try {
      String? groupSeed;
      for (var approxGroupId in [402, 394, 298, 291, 256]) {
        var groupSeed = await reader.readPointerInt("[[main+4268ee0]+330]+${(0x70+(approxGroupId)*0x440+0x408).toHex()}", 8);

        debug("${approxGroupId}: groupSeed: ${groupSeed.toHex()}");

        if (groupSeed == BigInt.zero) {
          continue;
        }

        for (var groupId in List.generate(30, (index) => approxGroupId + 20 - index)) {
          var groupSeed = await reader.readPointerInt("[[main+4268ee0]+330]+${(0x70+(groupId)*0x440+0x408).toHex()}", 8);

          debug("groupId: $groupId, groupSeed: ${groupSeed.toHex()}");

          if (groupSeed == BigInt.zero) {
            continue;
          }

          for (int i = 0; i < 4; i++) {
            var spawns = await reader.readPointerInt("[[[[main+427C470]+2B0]+58]+18]+${(0x60+(i*0x50)).toHex()}",1);

            if (spawns < BigInt.from(10) || spawns > BigInt.from(15)) {
              continue;
            }

            var species = await reader.readPointerInt("[[[[main+427C470]+2B0]+58]+18]+${(0x20+(i*0x50)).toHex()}",2);

            var generatorSeed = await reader.readPointerInt("[[main+4268ee0]+330]+${(0x70+groupId*0x440+0x20).toHex()}", 8);
            var groupSeed = (generatorSeed - BigInt.parse("82A2B175229D6A5B", radix: 16)) & BigInt.parse("FFFFFFFFFFFFFFFF", radix: 16);

            print([groupSeed.toRadixString(16), spawns.toInt(), species.toInt()].join(", "));
            return Future(() => MassOutbreakInformation(groupSeed.toRadixString(16), spawns.toInt(), species.toInt()));
          }
        }
      }
    } finally {
      reader.close();
    }
    return Future.error("Failed to find seed");
  }

  @override
  Future<SearchResult> search(MassOutbreakInformation moInfo, Filters filters, int rolls) {
    var pkmn = pokedex[moInfo.species]!;
    var result = searchMassOutbreak(
      BigInt.parse(moInfo.seed, radix: 16),
      moInfo.spawns,
      rolls,
      pkmn,
      (spawn) {
        if (filters.shiny && !spawn.shiny) {
          return false;
        }
        if (filters.alpha && !spawn.alpha) {
          return false;
        }
        if (!pkmn.isGenderFixed() && !(filters.male && filters.female)) {
          if (filters.male && spawn.gender != "M") {
            return false;
          }
          if (filters.female && spawn.gender != "F") {
            return false;
          }
        }

        return true;
      },
    );

    return Future.delayed(const Duration(seconds: 1), () => SearchResult(result!.seed, result.path, rolls, pokedex[moInfo.species]!));
  }

  @override
  dispose() {}
}
