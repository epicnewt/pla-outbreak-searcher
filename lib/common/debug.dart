import 'package:flutter/foundation.dart';

void debug(dynamic v) {
    if (kDebugMode) {
      print(v);
    }
}