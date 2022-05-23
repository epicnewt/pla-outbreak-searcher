import 'package:flutter/material.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/pokemon_sprite.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';
import 'package:provider/provider.dart';

class PokedexEntrySummary extends StatelessWidget {

  final PokedexEntry pokedexEntry;
  final Widget? subHeading;
  const PokedexEntrySummary({Key? key, required this.pokedexEntry, this.subHeading}) : super(key: key);

  bool caught() => PokedexStore.provide().pokedexCaught[pokedexEntry.pokemon] ?? false;
  bool complete() => PokedexStore.provide().pokedexCompletion[pokedexEntry.pokemon] ?? false;
  bool perfect() => PokedexStore.provide().pokedexPerfection[pokedexEntry.pokemon] ?? false;
  bool shinyCharm() => PokedexStore.provide().shinyCharm;

  toggleCaught() {
    PokedexStore.provide().toggleCaught(pokedexEntry.pokemon);
  }

  toggleCompletion() {
    PokedexStore.provide().toggleCompletion(pokedexEntry.pokemon);
  }

  togglePerfection() {
    PokedexStore.provide().togglePerfection(pokedexEntry.pokemon);
  }

  toggleShinyCharm() {
    PokedexStore.provide().toggleShinyCharm();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: toggleCaught,
            child: PokemonSprite(
              dexNumber: pokedexEntry.nationalDexNumber,
              checked: caught(),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokedexEntry.pokemon,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24 - 8),
                  ),
                  subHeading ?? const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 24 + 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 4),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Selector<PokedexStore, int>(
                              selector: (_, store) => store.select(pokedexEntry.pokemon),
                              builder: (context, value, child) => ToggleButtons(
                                constraints: BoxConstraints.expand(
                                  width: constraints.maxWidth / 3 - (3 + 1.0) / 3,
                                  height: 24,
                                ),
                                children: const [
                                  Text("Complete"),
                                  Text("Perfect"),
                                  Text("Shiny Charm"),
                                ],
                                onPressed: (index) {
                                  switch (index) {
                                    case 0:
                                      toggleCompletion();
                                      break;
                                    case 1:
                                      togglePerfection();
                                      break;
                                    default:
                                      toggleShinyCharm();
                                  }
                                },
                                isSelected: [shinyCharm() || (perfect()) || (complete()), (perfect()), shinyCharm()],
                              ),
                            );
                          },
                        ),
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
