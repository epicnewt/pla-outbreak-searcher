
Iterable<List<int>> passivePaths(int spawns, {int depth = 1, int maxDepth = 20, baseLimit = 11}) sync* {
  for (int d = depth; d <= maxDepth; d++) {
    var maxDespawns = BigInt.from(spawns - 4);
    final base = (maxDespawns >= BigInt.from(baseLimit)) ? BigInt.from(baseLimit) : (maxDespawns + BigInt.one);
    print("depth: $d, base: $base");
    var start = BigInt.zero;
    var end = (base - BigInt.one) * base.pow(d - 1);
    var step = BigInt.one;
    List<int> path = List.filled(d, 0);
    List<BigInt> bases = List.generate(d, (index) => base.pow(index));

    for (var p = start; p <= end; p += step) {
      var pathSum = BigInt.zero;

      if (depth != maxDepth && (p % base) > BigInt.zero) {
        continue;
      }

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
          var index = path.length - 1 - i;
          if (path[index] != 0) {
            break;
          }
          step = bases[index];
        }
      } else if (pathSum < maxDespawns) {
        step = BigInt.one;
      } else {
        continue;
      }

      yield path;
      // path = List.filled(d, 0);
    }
  }
}

main() {
  var sw = Stopwatch();
  for (var value in passivePaths(15)) {
  }
  print(sw.elapsed);
}
