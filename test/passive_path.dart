import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/pass_path_generator.dart';

main() {
  var sw = Stopwatch();

  //spawns, depth, baseLimit -> total

  Map<int, Map<int, Map<int, int>>> totalCombinations = {};

  for (int spawns = 10; spawns <= 15; spawns++) {
    totalCombinations.putIfAbsent(spawns, () => {});
    for (int depth = 0; depth <= 20; depth++) {
      totalCombinations[spawns]!.putIfAbsent(depth, () => {});
      for (var baseLimit in [5, 11]) {
        sw.start();
        var count = passivePaths(spawns, maxDepth: depth, despawnLimit: baseLimit).length;
        sw.stop();
        totalCombinations[spawns]![depth]![baseLimit] = count;
        print("passivePaths($spawns, maxDepth: $depth, baseLimit: $baseLimit) -> ${count} :: ${sw.elapsed}            \r");
        sw.reset();
      }
    }
  }

  // passivePaths(15, maxDepth: 1).forEach((element) {
  //   print(element);
  // });

  print(totalCombinations);
}