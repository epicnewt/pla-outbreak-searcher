import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/components/pokemon_sprite.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class PokedexEntrySummary extends StatelessWidget {
  final PokedexEntry pokedexEntry;
  final bool caught;
  final bool complete;
  final bool perfect;
  final bool shinyCharm;
  final Function(int)? onChange;

  const PokedexEntrySummary({
    Key? key,
    required this.pokedexEntry,
    required this.caught,
    required this.complete,
    required this.perfect,
    required this.shinyCharm,
    this.onChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => onChange?.call(3),
            child: PokemonSprite(
              dexNumber: pokedexEntry.nationalDexNumber,
              checked: caught,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      pokedexEntry.pokemon,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24 - 8),
                    ),
                  ),
                  SizedBox(
                    height: 24 + 4,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 4),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return ToggleButtons(
                              constraints: BoxConstraints.expand(
                                width: constraints.maxWidth / 3 - (3 + 1.0) / 3,
                                height: 24,
                              ),
                              children: const [
                                Text("Complete"),
                                Text("Perfect"),
                                Text("Shiny Charm"),
                              ],
                              onPressed: (index) => onChange?.call(index),
                              isSelected: [shinyCharm || complete, perfect, shinyCharm],
                            );
                          },
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
