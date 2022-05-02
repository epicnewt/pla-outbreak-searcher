import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/common/debug.dart';
import 'package:mmo_searcher/common/network/ip_address_scan.dart';
import 'package:mmo_searcher/common/network/nxreader.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_search_data.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_information.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class DefaultMassOutbreakSearcherService implements MassOutbreakSearcherService {
  @override
  Future<MassOutbreakInformation> gatherOutbreakInformation() async {
    String address = await findSwitchIpAddress();

    debug("Connecting to switch on $address:6000");

    var reader = NxReader(address);
    await reader.connect();
    try {
      for (var approxGroupId in [402, 394, 298, 291, 256]) {
        var groupSeed = await reader.readPointerInt("[[main+4268ee0]+330]+${(0x70 + (approxGroupId) * 0x440 + 0x408).toHex()}", 8);

        debug("$approxGroupId: groupSeed: ${groupSeed.toHex()}");

        if (groupSeed == BigInt.zero) {
          continue;
        }

        for (var groupId in List.generate(30, (index) => approxGroupId + 20 - index)) {
          var groupSeed = await reader.readPointerInt("[[main+4268ee0]+330]+${(0x70 + (groupId) * 0x440 + 0x408).toHex()}", 8);

          debug("groupId: $groupId, groupSeed: ${groupSeed.toHex()}");

          if (groupSeed == BigInt.zero) {
            continue;
          }

          for (int i = 0; i < 4; i++) {
            var spawns = await reader.readPointerInt("[[[[main+427C470]+2B0]+58]+18]+${(0x60 + (i * 0x50)).toHex()}", 1);

            if (spawns < BigInt.from(10) || spawns > BigInt.from(15)) {
              continue;
            }

            var species = await reader.readPointerInt("[[[[main+427C470]+2B0]+58]+18]+${(0x20 + (i * 0x50)).toHex()}", 2);

            var generatorSeed = await reader.readPointerInt("[[main+4268ee0]+330]+${(0x70 + groupId * 0x440 + 0x20).toHex()}", 8);
            var groupSeed = (generatorSeed - BigInt.parse("82A2B175229D6A5B", radix: 16)) & BigInt.parse("FFFFFFFFFFFFFFFF", radix: 16);

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
  Future<SearchResult> performSearch(MassOutbreakInformation moInfo, MassOutbreakSearchData filters, int rolls, bool multimatch, void Function(MassOutbreakResult?) onMatch, Function onTick) {
    var pkmn = pokedex[moInfo.species]!;

    isolatedSearch(
      SearchParams(
        moInfo.seed.parseUInt(radix: 16),
        moInfo.spawns ?? 10,
        rolls,
        pkmn,
        multimatch,
        filters.shiny,
        filters.alpha,
        filters.male,
        filters.female,
      ),
      onTick,
      onMatch,
    );

    return Future(() => SearchResult(0, [], rolls, pokedex[moInfo.species]!));
  }

  static void register() {
    GetIt.I.registerSingleton<MassOutbreakSearcherService>(DefaultMassOutbreakSearcherService());
  }
}
