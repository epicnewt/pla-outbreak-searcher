 import 'package:flutter/material.dart';
import 'package:mmo_searcher/navigator.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
          const DrawerHeader(child: Text("Pokémon Arcues Legends RNG Tools")),
          ListTile(
            selected: ModalRoute.of(context)?.settings.name?.contains("mo-") ?? false,
            title: const Text("v1.0.2"),
            onTap: () {
              AppRouteNavigator.provide().toMOSearch(context);
            },
          ),
          ListTile(
            selected: ModalRoute.of(context)?.settings.name?.contains("mmo-") ?? false,
            title: const Text("v1.1.X"),
            onTap: () {
              ModalRoute.of(context)?.isCurrent;
              AppRouteNavigator.provide().toMMOSearch(context);
            },
          ),
        ]),
      );
  }
  
}