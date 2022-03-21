import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      home: const SearchMassOutbreak(title: 'Flutter Demo Home Page'),
    );
  }
}

class SearchMassOutbreak extends StatefulWidget {
  const SearchMassOutbreak({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SearchMassOutbreak> createState() => _SearchMassOutbreakState();
}

class Filters {
  bool shiny = true;
  bool alpha = true;
  bool male = true;
  bool female = true;
}

class _SearchMassOutbreakState extends State<SearchMassOutbreak> {
  int _counter = 1;
  bool _showFilters = true;
  final List<bool> _rolls = [true, false, false];
  final Filters _filters = Filters();

  Socket? socket;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _counter++;
      reader.readPointer("[[main+4268ee0]+330]+697D0", 8).then((value) {
        String.fromCharCodes(value);

        print('[[main+4268ee0]+330]+697D0 8 -> $value');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Image.asset("assets/sprites/447.png"),
                const Text(
                  'Rioulu',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _showFilters = !_showFilters;
                      });
                    },
                    icon: const FaIcon(FontAwesomeIcons.filter)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'seed',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'spawns',
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return ToggleButtons(
                  constraints: BoxConstraints.expand(
                      width: constraints.maxWidth / 3 - (3 + 1.0) / 3,
                      height: 35),
                  children: const [
                    Text("Complete"),
                    Text("Perfect"),
                    Text("Shiny Charm"),
                  ],
                  onPressed: (i) {
                    setState(() {
                      _rolls[i] = !_rolls[i];
                    });
                  },
                  isSelected: _rolls,
                );
              },
            ),
            if (_showFilters) ...[
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.star),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Shiny"),
                  ),
                  Spacer(),
                  Switch.adaptive(
                    value: _filters.shiny,
                    onChanged: (v) {
                      setState(() {
                        _filters.shiny = v;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.faceAngry),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Alpha"),
                  ),
                  Spacer(),
                  Switch.adaptive(
                    value: _filters.alpha,
                    onChanged: (v) {
                      setState(() {
                        _filters.alpha = v;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.mars),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Male"),
                  ),
                  Spacer(),
                  Switch.adaptive(
                    value: _filters.male,
                    onChanged: (v) {
                      setState(() {
                        _filters.male = v;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.venus),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Female"),
                  ),
                  Spacer(),
                  Switch.adaptive(
                    value: _filters.female,
                    onChanged: (v) {
                      setState(() {
                        _filters.female = v;
                      });
                    },
                  )
                ],
              )
            ] else
              ...[],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("action('search')");
                    },
                    child: Text("Search"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
