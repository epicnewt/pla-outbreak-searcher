import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/spawn.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/pokemon_sprite.dart';

class SpawnDetails extends StatelessWidget {
  final Spawn spawn;

  const SpawnDetails({Key? key, required this.spawn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checked = false;
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: StatefulBuilder(builder: (context, setState) {
              return GestureDetector(
                onTap: () => setState(() { checked = !checked; }),
                child: PokemonSprite(
                  dexNumber: spawn.pkmn.nationalDexNumber,
                  form: spawn.form,
                  shiny: spawn.shiny,
                  alpha: spawn.alpha,
                  checked: checked,
                ),
              );
            }),
          ),
          ...(spawn.gender == "M" ? [const FaIcon(FontAwesomeIcons.mars, size: 18)] : []),
          ...(spawn.gender == "F" ? [const FaIcon(FontAwesomeIcons.venus, size: 18)] : []),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "${spawn.evs} ${spawn.nature}",
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}