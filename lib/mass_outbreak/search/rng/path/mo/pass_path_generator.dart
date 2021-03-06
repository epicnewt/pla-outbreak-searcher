import 'package:mmo_searcher/common/debug.dart';

const Map<int, Map<int, Map<int, int>>> totalCombinations = {
  10: {
    1: {5: 6, 11: 7},
    2: {5: 7, 11: 8},
    3: {5: 32, 11: 36},
    4: {5: 111, 11: 120},
    5: {5: 314, 11: 330},
    6: {5: 767, 11: 792},
    7: {5: 1680, 11: 1716},
    8: {5: 3383, 11: 3432},
    9: {5: 6371, 11: 6435},
    10: {5: 11359, 11: 11440},
    11: {5: 19348, 11: 19448},
    12: {5: 31703, 11: 31824},
    13: {5: 50244, 11: 50388},
    14: {5: 77351, 11: 77520},
    15: {5: 116084, 11: 116280},
    16: {5: 170319, 11: 170544},
    17: {5: 244901, 11: 245157},
    18: {5: 345815, 11: 346104},
    19: {5: 480376, 11: 480700},
    20: {5: 657439, 11: 657800}
  },
  11: {
    1: {5: 6, 11: 8},
    2: {5: 7, 11: 9},
    3: {5: 35, 11: 45},
    4: {5: 138, 11: 165},
    5: {5: 439, 11: 495},
    6: {5: 1187, 11: 1287},
    7: {5: 2841, 11: 3003},
    8: {5: 6190, 11: 6435},
    9: {5: 12518, 11: 12870},
    10: {5: 23824, 11: 24310},
    11: {5: 43108, 11: 43758},
    12: {5: 74735, 11: 75582},
    13: {5: 124890, 11: 125970},
    14: {5: 202138, 11: 203490},
    15: {5: 318104, 11: 319770},
    16: {5: 488289, 11: 490314},
    17: {5: 733039, 11: 735471},
    18: {5: 1078685, 11: 1081575},
    19: {5: 1558873, 11: 1562275},
    20: {5: 2216104, 11: 2220075}
  },
  12: {
    1: {5: 6, 11: 9},
    2: {5: 7, 11: 10},
    3: {5: 37, 11: 55},
    4: {5: 163, 11: 220},
    5: {5: 579, 11: 715},
    6: {5: 1727, 11: 2002},
    7: {5: 4507, 11: 5005},
    8: {5: 10607, 11: 11440},
    9: {5: 22998, 11: 24310},
    10: {5: 46649, 11: 48620},
    11: {5: 89528, 11: 92378},
    12: {5: 163967, 11: 167960},
    13: {5: 288482, 11: 293930},
    14: {5: 490153, 11: 497420},
    15: {5: 807684, 11: 817190},
    16: {5: 1295279, 11: 1307504},
    17: {5: 2027487, 11: 2042975},
    18: {5: 3105187, 11: 3124550},
    19: {5: 4662903, 11: 4686825},
    20: {5: 6877659, 11: 6906900}
  },
  13: {
    1: {5: 6, 11: 10},
    2: {5: 7, 11: 11},
    3: {5: 38, 11: 66},
    4: {5: 184, 11: 286},
    5: {5: 725, 11: 1001},
    6: {5: 2378, 11: 3003},
    7: {5: 6754, 11: 8008},
    8: {5: 17145, 11: 19448},
    9: {5: 39806, 11: 43758},
    10: {5: 85952, 11: 92378},
    11: {5: 174756, 11: 184756},
    12: {5: 337712, 11: 352716},
    13: {5: 624818, 11: 646646},
    14: {5: 1113139, 11: 1144066},
    15: {5: 1918430, 11: 1961256},
    16: {5: 3210635, 11: 3268760},
    17: {5: 5234231, 11: 5311735},
    18: {5: 8334557, 11: 8436285},
    19: {5: 12991458, 11: 13123110},
    20: {5: 19861784, 11: 20030010}
  },
  14: {
    1: {5: 6, 11: 11},
    2: {5: 7, 11: 12},
    3: {5: 38, 11: 78},
    4: {5: 199, 11: 364},
    5: {5: 865, 11: 1365},
    6: {5: 3113, 11: 4368},
    7: {5: 9610, 11: 12376},
    8: {5: 26287, 11: 31824},
    9: {5: 65294, 11: 75582},
    10: {5: 149951, 11: 167960},
    11: {5: 322696, 11: 352716},
    12: {5: 657395, 11: 705432},
    13: {5: 1277834, 11: 1352078},
    14: {5: 2384773, 11: 2496144},
    15: {5: 4294622, 11: 4457400},
    16: {5: 7493615, 11: 7726160},
    17: {5: 12712327, 11: 13037895},
    18: {5: 21026519, 11: 21474180},
    19: {5: 33991626, 11: 34597290},
    20: {5: 53819743, 11: 54627300}
  },
  15: {
    1: {5: 6, 11: 12},
    2: {5: 7, 11: 13},
    3: {5: 38, 11: 91},
    4: {5: 209, 11: 455},
    5: {5: 990, 11: 1820},
    6: {5: 3893, 11: 6188},
    7: {5: 13041, 11: 18564},
    8: {5: 38404, 11: 50388},
    9: {5: 101982, 11: 125970},
    10: {5: 248930, 11: 293930},
    11: {5: 566621, 11: 646646},
    12: {5: 1216008, 11: 1352078},
    13: {5: 2481466, 11: 2704156},
    14: {5: 4847675, 11: 5200300},
    15: {5: 9115165, 11: 9657700},
    16: {5: 16570020, 11: 17383860},
    17: {5: 29228083, 11: 30421755},
    18: {5: 50179989, 11: 51895935},
    19: {5: 84070668, 11: 86493225},
    20: {5: 137755815, 11: 141120525}
  }
};

Iterable<List<int>> passivePaths(int spawns, {int depth = 1, int maxDepth = 20, despawnLimit = 11}) sync* {
  for (int d = depth; d <= maxDepth; d++) {
    debug("Running v1.0.2 search at depth $d");
    var maxDespawns = spawns - 4;
    final int base = ((maxDespawns > despawnLimit) ? despawnLimit : maxDespawns) + 1;
    final List<int> path = List.filled(d, 0);

    final int baseMax = base - 1;
    var pathSum = 0;
    var maxPathSum = maxDespawns.toInt();

    var lastI = path.length - 1;
    var step = lastI;

    setStep() {
      for (int j = lastI; j >= 0; j--) {
        var value = path[j];
        if (value != 0) {
          step = j;
          break;
        }
      }
    }

    add() {
      if (path[step] == baseMax) {
        for (int i = step; i >= 0; i--) {
          if (path[i] != baseMax) {
            path[i] += 1;
            pathSum += 1;
            break;
          }
          path[i] = 0;
          pathSum -= baseMax;
        }
      } else {
        pathSum += 1;
        path[step] += 1;
      }
    }

    int last() => path[lastI];

    while (path[0] != baseMax) {
      if (depth != maxDepth && last() > 0) {
        add();
        continue;
      }

      if (pathSum == maxPathSum) {
        setStep();
        yield path;
      } else if (pathSum < maxPathSum) {
        step = lastI;
        yield path;
      }

      add();
    }

    if (d != 1 || maxDepth == 1) {
      yield path;
    }
  }
}
