import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/common/debug.dart';
import 'package:mmo_searcher/common/network/ip_address_scan.dart';
import 'package:mmo_searcher/common/network/nxreader.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';

class DefaultMassOutbreakSearcherService implements MassOutbreakSearcherService {
  @override
  Future<List<MassOutbreakInformation>> gatherOutbreakInformation() async {
    String address = await findSwitchIpAddress();

    debug("Connecting to switch on $address:6000");

    const townSpawnPointer = "[[[[main+427C470]+2B0]+58]+18]";

    var reader = NxReader(address);
    await reader.connect();

    var outbreaks = <MassOutbreakInformation>[];

    try {
      for (var map = 0; map < 5; map++) {
        var groupSeed = await reader.readPointerInt("$townSpawnPointer+${(0x58 + (map * 0x50)).toHex()}", 8);

        if (groupSeed == BigInt.zero) {
          continue; // break?
        }

        var species = await reader.readPointerInt("$townSpawnPointer+${(0x20 + (map * 0x50)).toHex()}", 2);
        var spawns = (await reader.readPointerInt("$townSpawnPointer+${(0x60 + (map * 0x50)).toHex()}", 8)).toInt();

        if (spawns < 10 || spawns > 15) {
          continue;
        }

        print("FOUND: ${pokedex[species]?.pokemon ?? ''}($species) $spawns ${groupSeed.toHex()}");

        outbreaks.add(
          MassOutbreakInformation(
            groupSeed.toRadixString(16),
            spawns,
            species.toInt(),
          ),
        );
      }
      return Future.value(outbreaks);
    } catch (e) {
      return Future.error("Failed to find seed");
    } finally {
      reader.close();
    }
  }

  @override
  Future<List<MassOutbreakResult?>> performSearch(MassOutbreakSearchData info) async {
    debug("Start v1.0.2 search");

    var searchFutures = (info.moInfo ?? []).map((moInfo) {
      var completer = Completer<MassOutbreakResult?>();
      var pkmn = pokedex[moInfo.species]!;
      isolatedSearch(
        SearchParams(
          moInfo.seed.parseUInt(radix: 16),
          moInfo.spawns ?? 10,
          26 + PokedexStore.getRolls(pkmn.pokemon),
          pkmn,
          info.multimatch,
          info.shiny,
          info.alpha,
          info.male,
          info.female,
        ),
        () {},
        (result) {
          if (result != null) {
            print("Setting filter");
            result.filter = (spawn) {
              var rtrn = (!info.shiny || spawn.shiny) //
               && (!info.alpha || spawn.alpha) //
               ;//&& (spawn.gender == 'G' || (info.male && spawn.gender == 'M') || (info.female && spawn.gender == 'F'));
               print("${spawn} -> $rtrn");
               return rtrn;
            };
          }
          completer.complete(result);
        },
      );
      return completer.future;
    });

    return Future.wait(searchFutures);
  }

  static void register() {
    GetIt.I.registerSingleton<MassOutbreakSearcherService>(DefaultMassOutbreakSearcherService());
  }
}
