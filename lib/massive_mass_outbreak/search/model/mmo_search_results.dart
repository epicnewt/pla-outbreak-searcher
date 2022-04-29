import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_info.dart';
import 'package:mmo_searcher/massive_mass_outbreak/search/model/mmo_path_spawn_info.dart';

class MMOSearchResults {
  final MMOInfo mmo;
  final List<PathSpawnInfo> paths;

  MMOSearchResults(this.mmo, this.paths);
}