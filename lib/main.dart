import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/components/mass_outbreak_search.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/filters.dart';

void main() {
  runApp(const MyApp());
}

extension Hex on int {
  toHex() {
    return toRadixString(16).toUpperCase();
  }
}

class NxReader {
  Socket? connection;
  List<int> input = [];
  bool locked = false;
  String host;

  NxReader(this.host) {
    print('Starting initial connection!');
    this.connect().then(
      (value) {
        print('Initial connection!');
      },
    );
  }

  Future<dynamic> connect() async {
    // host
    connection = await Socket.connect(host, 6000);
    print("Connected to $host");
    connection?.write("configure echoCommands 0\r\n");
    connection?.listen((event) {
      print('Received: $event');
      input.addAll(event);
    });
  }

  Future<T> acquireLock<T>(Future<T> Function() fn) async {
    if (!locked && connection != null) {
      locked = true;
      var result = await fn();
      locked = false;
      return result;
    }

    print("Waiting for lock");
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
    connection?.write(command + '\r\n');
  }

  Future<List<int>> readPointer(String pointer, int size) async {
    print('readPointer($pointer)');
    var jumps = pointer
        .replaceAll("[", "")
        .replaceAll('+', '')
        .replaceFirst("main", "")
        .replaceAll('+', '')
        .split("]")
        .map((j) => {j.toUpperCase()});

    return acquireLock(() async {
      sendCommand('pointerPeek 0x${size.toHex()} 0x${jumps.join(' 0x')}');
      return readLine();
    });
  }
}

var reader = NxReader("192.168.0.10");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SearchMassOutbreak(),
    );
  }
}

class SearchMassOutbreak extends StatelessWidget {
  const SearchMassOutbreak({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
@override
  Widget build(BuildContext context) {
    return dummyMassOutbreakSearch;
  }
}
