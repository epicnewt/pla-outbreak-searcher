import 'dart:io';

import 'package:mmo_searcher/mass_outbreak/search/rng/xoroshiro.dart';

void main() {
  var rng = XOROSHIRO();
  rng.reseed(BigInt.parse("0xA83FEC027959DBC4"));
  for (var i = 0; i< 10; i++) {
    // print("${rng.rand(BigInt.from(2420)).toRadixString(16).toUpperCase()} -> ${rng.state().toRadixString(16).toUpperCase()}");
  }
}

void scanForSwitchAddress() {
  List<Future<String>> f = [];
  for (var i = 100; i > 0; i--) {
      var soc = Socket.connect("192.168.0.$i", 6000, timeout: Duration(seconds: 1)).then((value) {
        print("Connected to 192.168.0.$i");
        return "192.168.0.$i";
      }).onError((error, stackTrace) {
        return "";
      });
      f.add(soc);
  }

  Future.wait(f).then((value) {
    return value.where((element) => element.isNotEmpty);
  });
}
