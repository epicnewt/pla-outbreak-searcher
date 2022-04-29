import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/meta_data/encounter_slots.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_advancer.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_path_generator.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/mmo_search_service.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_search_results.dart';
import 'package:mmo_searcher/num.dart';

class MMOSearchServiceStub extends MMOSearchService {
  @override
  Future<List<MMOInfo>> gatherOutbreakInformation() async {
    print("MMOSearchServiceStub#gatherOutbreakInformation()");
    return [
      MMOInfo(
        "",
        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
        9,
        7,
        encounterSlotsMap["E680740C6BE14EFB"]!,
        null,
      ),
      MMOInfo(
        "",
        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
        9,
        7,
        encounterSlotsMap["D3FB11A4B88400FC"]!,
        encounterSlotsMap["64064A0B10810230"]!,
      ),
      MMOInfo(
        "",
        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
        9,
        7,
        encounterSlotsMap["C213972F6D316665"]!,
        encounterSlotsMap["EEFEE"]!,
      ),
      MMOInfo(
        "",
        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
        9,
        7,
        encounterSlotsMap["C213972F6D316665"]!,
        encounterSlotsMap["EEFEE"]!,
      ),
      MMOInfo(
        "",
        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
        9,
        7,
        encounterSlotsMap["7FA3A1DE69BD271E"]!,
        encounterSlotsMap["21C03B7FF717BBAB"]!,
      ),
      MMOInfo(
        "",
        BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
        9,
        7,
        encounterSlotsMap["8E51750B5EB775A0"]!,
        encounterSlotsMap["EEFEE"]!,
      )
    ];
  }

  @override
  Future<List<MMOSearchResults>> performSearch(List<MMOInfo> outbreaks) async {
    print("MMOSearchServiceStub#performSearch([..])");
    return outbreaks
        .map((e) => MMOSearchResults(e, [
              generateSpawnsOfPath(
                  MMOPath(MutableMMOPath.withPaths([1, 3, 1], [1], [2, 1])),
                  MMOInfo(
                    "",
                    BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                    9,
                    7,
                    encounterSlotsMap["41E4947058A65FD8"]!,
                    encounterSlotsMap["702EDC94E9044B34"]!,
                  ),
                  1400,
                  alphaRequired: false,
                  shinyRequired: true)!,
              generateSpawnsOfPath(
                  MMOPath(MutableMMOPath.withPaths([1, 2, 1, 1], [2, 1], [3])),
                  MMOInfo(
                    "",
                    BigInt.parse("895610BECE218FD3", radix: 16).toUInt(),
                    9,
                    7,
                    encounterSlotsMap["D3FB11A4B88400FC"]!,
                    encounterSlotsMap["64064A0B10810230"]!,
                  ),
                  4000,
                  alphaRequired: false,
                  shinyRequired: false)!,
            ]))
        .toList();
  }

  static void register() {
    GetIt.I.registerSingleton<MMOSearchService>(MMOSearchServiceStub());
  }
}
