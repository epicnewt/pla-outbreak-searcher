
Iterable<List<int>> passivePaths(int spawns, {int depth = 1, int maxDepth = 20}) sync* {
  for (int d = depth; d <= maxDepth; d++) {
    var maxDespawns = BigInt.from(spawns - 4);
    final base = maxDespawns + BigInt.one;
    var start = BigInt.zero;
    var end = (base - BigInt.one) * base.pow(d - 1);
    var step = BigInt.one;
    List<int> path = List.filled(d, 0);

    for (var p = start; p <= end; p += step) {
      var pathSum = BigInt.zero;

      var r = p;
      var i = path.length - 1;
      while (r > BigInt.zero) {
        var digit = r % base;
        pathSum += digit;
        r = r ~/ base;
        path[i--] = digit.toInt();
      }

      if (i > 0) {
        path.fillRange(0, i, 0);
      }

      if (pathSum == maxDespawns) {
        for (i = 0; i < d; i++) {
          if (path[path.length - 1 - i] != 0) {
            break;
          }
          step = base.pow(i);
        }
      } else if (pathSum < maxDespawns) {
        step = BigInt.one;
      } else {
        continue;
      }

      yield path;
      path = List.filled(d, 0);
    }
  }
}