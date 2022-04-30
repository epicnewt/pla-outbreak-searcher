import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_advancer.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/num.dart';
import 'package:mmo_searcher/nxreader.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class MassiveMassOutbreakPointerDebugScreen extends StatelessWidget {
  const MassiveMassOutbreakPointerDebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MMO Debug"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            var data = "";
            return StatefulBuilder(
              builder: (context, setState) {
                void refresh() async {
                  var mapNames = {
                    BigInt.from(0x5504): "Crimson Mirelands",
                    BigInt.from(0x5351): "Alabaster Icelands",
                    BigInt.from(0x519E): "Coronet Highlands",
                    BigInt.from(0x5A1D): "Obsidian Fieldlands",
                    BigInt.from(0x56B7): "Cobalt Coastlands"
                  };

                  var update = "";
                  var reader = NxReader("192.168.0.10");
                  reader.connect();
                  try {
                    for (var map = 0; map < 5; map++) {
                      var name = await reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(0x1d4 + 0xb80 * map - 0x24).toHex()}", 2);

                      if (mapNames[name] == null) {
                        continue;
                      }

                      update += "Map: ${name.toHex()}:${mapNames[name]}\n";

                      var mmoInfo = (await Future.wait(List.generate(16, (groupId) async {
                        var pointerRoot = 0x1d4 + groupId * 0x90 + 0xb80 * map;
                        var numspecies = await reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(pointerRoot).toHex()}", 2);

                        if (numspecies == BigInt.zero || numspecies > BigInt.one << 11) {
                          return null;
                        }

                        var initialRound = await reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(pointerRoot + 0x24).toHex()}", 8);
                        var initialRoundEncounterSlots = encounterSlotsMap[initialRound.toHex()];
                        if (initialRoundEncounterSlots == null) {
                          return null;
                        }
                        var initialSpawns = await reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(pointerRoot + 0x4C).toHex()}", 4);

                        var bonusRound = await reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(pointerRoot + 0x2c).toHex()}", 8);
                        var bonusRoundEncounterSlots = encounterSlotsMap[bonusRound.toHex()];
                        var hasBonusRound = bonusRoundEncounterSlots != null;
                        var groupSeed = await reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(pointerRoot + 0x44).toHex()}", 8);
                        late var bonusSpawns = reader.readPointerInt("[[[[[[main+42BA6B0]+2B0]+58]+18]+${(pointerRoot + 0x60).toHex()}", 4);

                        return MMOInfo(
                          mapNames[name]!,
                          groupSeed.toUInt(),
                          initialSpawns.toInt(),
                          hasBonusRound ? (await bonusSpawns).toInt() : null,
                          initialRoundEncounterSlots,
                          bonusRoundEncounterSlots,
                        );
                      })))
                          .where((e) => e != null)
                          .map((e) => e!);

                      for (var info in mmoInfo) {
                        update += "\n  ${info.groupSeed.toHex()}\n";
                        update += "\n    Initial round of ${info.spawns}:\n";
                        for (var pkmn in info.initialRoundEncouterTable.slots) {
                          update += "      ${pkmn.name}${pkmn.alpha ? "-a" : ""}\n";
                        }
                        if (info.bonusRoundEncouterTable != null) {
                          update += "    Bonus round of ${info.bonusSpawns}:\n";
                          for (var pkmn in info.initialRoundEncouterTable.slots) {
                            update += "      ${pkmn.name}${pkmn.alpha ? "-a" : ""}\n";
                          }
                        }

                        for (var path in aggressivePaths(spawns: info.spawns, bonusSpawns: info.bonusSpawns ?? 0)) {
                          var spawnInfo = generateSpawnsOfPath(path, info, alphaRequired: true, shinyRequired: true);
                          if (spawnInfo == null) {
                            continue;
                          }
                          update += "      ${path}\n";
                          for (var pkmns in spawnInfo.pokemon) {
                            for (var pkmn in pkmns) {
                              update += "        $pkmn\n";
                            }
                            update += "\n";
                          }
                        }
                      }

                      update += "\n";
                    }
                    setState(() {
                      data = update;
                    });
                    // } catch (err) {
                    //   print(err);
                  } finally {
                    reader.close();
                  }
                }

                if (data.isEmpty) {
                  refresh();
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              refresh();
                            },
                            child: const Text("Refresh")),
                      ],
                    ),
                    Row(
                      children: [
                        Text(data),
                      ],
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
