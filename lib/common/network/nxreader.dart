import 'dart:io';

import 'package:mmo_searcher/common/debug.dart';
import 'package:mmo_searcher/num.dart';

class NxReader {
  Socket? connection;
  List<int> input = [];
  bool locked = false;
  String host;

  NxReader(this.host);

  void close() {
    connection?.close();
  }

  Future<dynamic> connect() async {
    // host
    connection = await Socket.connect(host, 6000);
    
    debug("Connected to $host");
    
    connection?.write("configure echoCommands 0\r\n");
    connection?.listen((event) {
      
      debug('Received: $event');
      
      input.addAll(event);
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<T> acquireLock<T>(Future<T> Function() fn) async {
    if (!locked && connection != null) {
      locked = true;
      var result = await fn();
      locked = false;
      return result;
    }

    // 
    // debug("Waiting for lock");
    // 
    return Future.delayed(Duration.zero, () => acquireLock(fn));
  }

  Future<List<int>> readLine() async {
    var lineEnd = input.indexOf(10);

    if (lineEnd < 0) {
      return Future.delayed(Duration.zero, () => readLine());
    }

    var data = input.sublist(0, lineEnd);
    input.removeRange(0, lineEnd + 1);
    return data;
  }

  void sendCommand(String command) {
    
    debug('$command -- ${command.replaceAll("[}{]", "")}');
    
    connection?.write(command + '\r\n');
  }
  Future<BigInt> readPointerInt(String pointer, int size) async {
    var chars = await readPointer(pointer, size);
    var hexlifiied = String.fromCharCodes(chars);
    var value = "";
    for (var i = hexlifiied.length - 2; i >= 0; i -= 2) {
      value += hexlifiied.substring(i, i + 2);
    }
    
    debug("unhexlify($hexlifiied$chars) === $value");
    
    return BigInt.parse(value, radix: 16);
  }

  Future<List<int>> readPointer(String pointer, int size) async {
    
    debug("pointerPeek $pointer $size");
    
    var jumps = pointer.replaceAll("[", "").replaceAll('+', '').replaceFirst("main", "").replaceAll('+', '').split("]").map((j) => j.toUpperCase());

    return acquireLock(() async {
      sendCommand("pointerPeek 0x${size.toHex()} 0x${jumps.join(' 0x')}");
      return readLine();
    });
  }
}


