import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

Future<List<String>> findSwitchIpAddress() async {
  List<Future<String>> futures = [];
  await for (var item in _ipAddresses().map((ipAddress) {
    return Socket.connect(ipAddress, 6000, timeout: const Duration(seconds: 2)).then((socket) {
      socket.close();
      return ipAddress;
    }).onError((error, stackTrace) => "");
  })) {
    futures.add(item);
  }

  return (await Future.wait(futures)).where((element) => element.isNotEmpty).toList();
}

Stream<String> _ipAddresses() async* {
  WidgetsFlutterBinding.ensureInitialized();
  final info = NetworkInfo();
  var wifiIp = await info.getWifiIP();
  var taken = [wifiIp, await info.getWifiBroadcast(), await info.getWifiGatewayIP()];
  var wifiIpParts = (wifiIp ?? "0.0.0.0").split(RegExp("\\.")).map(int.parse).toList();
  var wifiSubmask = (await info.getWifiSubmask() ?? "255.255.255.255").split(RegExp("\\.")).map(int.parse).toList();

  var range = Iterable<int>.generate(255).toList();

  for (var a in (wifiSubmask[0] == 0 ? range : [wifiIpParts[0]])) {
    for (var b in (wifiSubmask[1] == 0 ? range : [wifiIpParts[1]])) {
      for (var c in (wifiSubmask[2] == 0 ? range : [wifiIpParts[2]])) {
        for (var d in (wifiSubmask[3] == 0 ? range : [wifiIpParts[3]])) {
          var ip = "$a.$b.$c.$d";
          if (taken.contains(ip)) {
            continue;
          }
          yield ip;
        }
      }
    }
  }
}