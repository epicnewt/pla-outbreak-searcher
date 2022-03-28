
Iterable<List<int>> passivePaths(int spawns, {int depth = 1, int maxDepth = 20, baseLimit = 11}) sync* {
  for (int d = depth; d <= maxDepth; d++) {
    var maxDespawns = BigInt.from(spawns - 4);
    final base = ((maxDespawns + BigInt.one) > BigInt.from(baseLimit)) ? BigInt.from(baseLimit) : (maxDespawns + BigInt.one);
    print("depth: $d, base: $base");
    var start = BigInt.zero;
    var end = (base - BigInt.one) * base.pow(d - 1);
    var step = BigInt.one;
    List<int> path = List.filled(d, 0);
    List<BigInt> bases = List.generate(d, (index) => base.pow(index)).reversed.toList();

    for (var p = start; p <= end; p += step) {
      var pathSum = BigInt.zero;

      if (depth != maxDepth && (p % base) > BigInt.zero) {
        continue;
      }

      var r = p;
      var i = path.length;
      var s = true;
      while (r > BigInt.zero) {
        var digit = r % base;
        pathSum += digit;
        r = r ~/ base;
        path[--i] = digit.toInt();

        if (s) {
          s = s && digit == BigInt.zero;
          if (!s) {
            step = bases[i];
          }
        }
      }

      if (pathSum > maxDespawns) {
        continue;
      }

      if (i > 0) {
        path.fillRange(0, i, 0);
      }


      if (pathSum != maxDespawns) {
        step = BigInt.one;
      }

      yield path;
      // path = List.filled(d, 0);
    }
  }
}

main() {
  var sw = Stopwatch();
  sw.start();
  for (var value in passivePaths(14, maxDepth: 15, baseLimit: 11)) {
    print(value);
  } //1:44 to beat
  sw.stop();
  print(sw.elapsed);
}
