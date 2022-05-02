import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mmo_searcher/massive_mass_outbreak/pages/widgets/pokemon_sprite.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:mmo_searcher/pokedex/pokedex_store.dart';

class PokedexEntrySummary extends StatefulWidget {
  final PokedexEntry pokedexEntry;
  final Widget? subHeading; 
  const PokedexEntrySummary({Key? key, required this.pokedexEntry, this.subHeading}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PokedexEntrySummary> createState() => _PokedexEntrySummaryState(subHeading: subHeading);
}

class _PokedexEntrySummaryState extends State<PokedexEntrySummary> {
  late bool caught = GetIt.I.get<PokedexStore>().pokedexCaught[widget.pokedexEntry.pokemon] ?? false;

  late bool complete = GetIt.I.get<PokedexStore>().pokedexCompletion[widget.pokedexEntry.pokemon] ?? false;

  late bool perfect = GetIt.I.get<PokedexStore>().pokedexPerfection[widget.pokedexEntry.pokemon] ?? false;

  late bool shinyCharm = GetIt.I.get<PokedexStore>().shinyCharm;

  final Widget? subHeading;

  _PokedexEntrySummaryState({this.subHeading});

  toggleCaught() {
    setState(() {
      caught = !caught;
    });
    GetIt.I.get<PokedexStore>().toggleCaught(widget.pokedexEntry.pokemon);
  }

  toggleCompletion() {
    complete = !complete;
    GetIt.I.get<PokedexStore>().toggleCompletion(widget.pokedexEntry.pokemon);
  }

  togglePerfection() {
    perfect = !perfect;
    GetIt.I.get<PokedexStore>().togglePerfection(widget.pokedexEntry.pokemon);
  }

  toggleShinyCharm() {
    shinyCharm = !shinyCharm;
    GetIt.I.get<PokedexStore>().toggleShinyCharm();
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
              dexNumber: widget.pokedexEntry.nationalDexNumber,
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
                  Text(
                      widget.pokedexEntry.pokemon,
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
                              onPressed: (index) => setState(() {
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
                              }),
                              isSelected: [shinyCharm || (perfect) || (complete), (perfect), shinyCharm],
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
