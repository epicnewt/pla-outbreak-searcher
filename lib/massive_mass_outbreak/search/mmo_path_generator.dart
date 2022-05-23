import 'dart:math';
import 'dart:core';

import 'package:collection/collection.dart';

class MutableMMOPath {
  List<int> initialPath = [];
  List<int> revisit = [];
  List<int> bonusPath = [];
  late final MMOPath _readonly = MMOPath(this);

  MutableMMOPath();
  MutableMMOPath.withPaths(this.initialPath, this.revisit, this.bonusPath);
  MutableMMOPath.clone(MutableMMOPath src) : this.withPaths([...src.initialPath], [...src.revisit], [...src.bonusPath]);

  @override
  String toString() {
    return initialPath.toString() + //
        ((revisit.isNotEmpty || bonusPath.isNotEmpty) ? " + $revisit" : "") + //
        (bonusPath.isNotEmpty ? " + $bonusPath" : "");
  }

  MMOPath get readonly => _readonly;
}

class MMOPath {
  final MutableMMOPath _mmoPath;

  MMOPath(this._mmoPath);

  List<int> get initialPath => _mmoPath.initialPath;

  List<int> get revisit => _mmoPath.revisit;

  List<int> get bonusPath => _mmoPath.bonusPath;

  MMOPath copy() => MutableMMOPath.clone(_mmoPath).readonly;

  @override
  String toString() {
    return _mmoPath.toString();
  }
}

Iterable<List<int>> _aggressivePaths(int spawns, {int length = 1, bool includeInitial = true, bool includeEmpty = true, int maxDespawnsPerStep = 4}) sync* {
  if (length == 1) {
    if (includeEmpty) {
      yield [];
    }
    if (includeInitial) {
      yield [0];
    }
  }

  var maxDespawns = spawns - 4;
  var maxPathAction = min(maxDespawns - length + 1, maxDespawnsPerStep);
  List<int> path = List.filled(length, 1, growable: false);

  var step = length - 1;

  bool add() {
    //returns false on overflow
    for (int i = step; i >= 0; i--) {
      if (path[i] < maxPathAction) {
        path[i] += 1;
        return true;
      } else {
        path[i] = 1;
      }
    }
    return false;
  }

  do {
    if (path.sum <= maxDespawns) {
      yield path;
    }
  } while (add());

  if (length < maxDespawns) {
    yield* _aggressivePaths(spawns, length: length + 1);
  }
}

/// Returns the number of pokemon that should remain before despawning and returning
Iterable<List<int>> revisits({required int remainingSpawns}) => [
      [],
      [1],
      [2],
      [2, 1],
      [3],
      [3, 1],
      [3, 2],
      [3, 2, 1]
    ];

Iterable<MMOPath> aggressivePaths({required int spawns, int bonusSpawns = 0}) sync* {
  var maxDespawns = spawns - 4;
  MutableMMOPath mmoPath = MutableMMOPath();

  for (var initialPath in _aggressivePaths(spawns, includeEmpty: false)) {
    mmoPath.initialPath = initialPath;
    mmoPath.bonusPath = [];

    if (initialPath.sum == maxDespawns) {
      if (bonusSpawns > 0) {
        for (var revisit in revisits(remainingSpawns: spawns - initialPath.sum)) {
          mmoPath.revisit = revisit;
          for (var bonusPath in _aggressivePaths(bonusSpawns, includeEmpty: false)) {
            mmoPath.bonusPath = bonusPath;
            yield mmoPath.readonly;
          }
        }
      } else {
        yield mmoPath.readonly;
      }
    } else {
      mmoPath.revisit = [];
      yield mmoPath.readonly;
    }
  }
}
