import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';

class MMOInfo {
  final int groupSeed;
  final int spawns;
  final int? bonusSpawns;
  final EncounterTable initialRoundEncouterTable;
  final EncounterTable? bonusRoundEncouterTable;

  MMOInfo(this.groupSeed, this.spawns, this.bonusSpawns, this.initialRoundEncouterTable, this.bonusRoundEncouterTable);

}
