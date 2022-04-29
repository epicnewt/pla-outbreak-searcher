import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_advancer.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/nxreader.dart';

import '../meta_data/encounter_slots.dart';

abstract class MMOSearchService {
  Future<List<MMOInfo>> gatherOutbreakInformation();
  Future<List<MMOSearchResults>> performSearch(List<MMOInfo> outbreaks);

  static MMOSearchService provide() {
    return GetIt.I.get<MMOSearchService>();
  }
}

class DefaultMMOSearchService implements MMOSearchService {
  @override
  Future<List<MMOInfo>> gatherOutbreakInformation() async {
    List<Future<MMOInfo?>> outbreaks = [];

    var mapNames = {
      BigInt.from(0x5504): "Crimson Mirelands",
      BigInt.from(0x5351): "Alabaster Icelands",
      BigInt.from(0x519E): "Coronet Highlands",
      BigInt.from(0x5A1D): "Obsidian Fieldlands",
      BigInt.from(0x56B7): "Cobalt Coastlands"
    };

    var mmoPointer = "[[[[[[main+42BA6B0]+2B0]+58]+18]";

    var reader = NxReader("192.168.0.10");
    reader.connect();
    try {
      for (var map = 0; map < 5; map++) {
        var name = await reader.readPointerInt("$mmoPointer+${(0x1d4 + 0xb80 * map - 0x24).toHex()}", 2);

        if (mapNames[name] == null) {
          continue;
        }
        List.generate(16, (groupId) async {
          var pointerRoot = 0x1d4 + groupId * 0x90 + 0xb80 * map;
          var numspecies = await reader.readPointerInt("$mmoPointer+${(pointerRoot).toHex()}", 2);

          if (numspecies == BigInt.zero || numspecies > BigInt.one << 11) {
            return null;
          }

          var initialRound = await reader.readPointerInt("$mmoPointer+${(pointerRoot + 0x24).toHex()}", 8);
          var initialRoundEncounterSlots = encounterSlotsMap[initialRound.toHex()];
          if (initialRoundEncounterSlots == null) {
            return null;
          }
          var initialSpawns = await reader.readPointerInt("$mmoPointer+${(pointerRoot + 0x4C).toHex()}", 4);

          var bonusRound = await reader.readPointerInt("$mmoPointer+${(pointerRoot + 0x2c).toHex()}", 8);
          var bonusRoundEncounterSlots = encounterSlotsMap[bonusRound.toHex()];
          var hasBonusRound = bonusRoundEncounterSlots != null;
          var groupSeed = await reader.readPointerInt("$mmoPointer+${(pointerRoot + 0x44).toHex()}", 8);
          late var bonusSpawns = reader.readPointerInt("$mmoPointer+${(pointerRoot + 0x60).toHex()}", 4);

          return MMOInfo(
            mapNames[name]!,
            groupSeed.toUInt(),
            initialSpawns.toInt(),
            hasBonusRound ? (await bonusSpawns).toInt() : null,
            initialRoundEncounterSlots,
            bonusRoundEncounterSlots,
          );
        }).forEach(outbreaks.add);
      }
    } finally {
      reader.close();
    }

    return (await Future.wait(outbreaks)) //
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  Future<List<MMOSearchResults>> performSearch(List<MMOInfo> outbreaks) async {
    // TODO :: Run in an isolate
    return outbreaks
        .map((info) {
          return MMOSearchResults(
            info,
            aggressivePaths(spawns: info.spawns, bonusSpawns: info.bonusSpawns ?? 0) //
                .map((path) => generateSpawnsOfPath(path, info, 14, alphaRequired: true, shinyRequired: true))
                .where((element) => element != null)
                .map((e) => e!)
                .toList(),
          );
        })
        .where((results) => results.paths.isNotEmpty)
        .toList();
  }

  static void register() {
    GetIt.I.registerSingleton<MMOSearchService>(DefaultMMOSearchService());
  }
}