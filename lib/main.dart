import 'package:flutter/material.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/mass_outbreak_search.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/mass_outbreak_search_result.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/massive_mass_outbreak_pointer_debug_screen.dart';

bool demo = true;

void main() {
  runApp(MaterialApp(
    title: "Pokémon Arceus Legends RNG Tools",
    initialRoute: 'mmo-pointer-debug',
    // initialRoute: 'mo-search',
    routes: {
      'mo-search': (context) => dummyMassOutbreakSearch, 
      'mo-search-results': (context) => const MassOutbreakSearchResult(),
      'mmo-pointer-debug': (context) => const MassiveMassOutbreakPointerDebugScreen()
      },
  ));
}

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
      home: Builder(builder: (context) {
        // return dummyMassOutbreakSearch;
        return MassOutbreakSearchResult();
      }),
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
