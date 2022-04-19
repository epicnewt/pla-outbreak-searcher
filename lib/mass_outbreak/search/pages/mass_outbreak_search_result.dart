import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/state/mass_outbreak_rolls_state.dart';
import 'package:mmo_searcher/mass_outbreak/search/rng/path/mo/search.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';
import 'package:provider/provider.dart';

class MassOutbreakSearchResultState extends ChangeNotifier {
  int _seed;
  List<int> _path;
  PokedexEntry _pkmn;
  int _rolls = 27;

  Map<int, List<Advance>> cache = {};

  List<Advance> get advances {
    var lookup = cache[_rolls];
    if (lookup == null) {
      lookup = MassOutbreakResult(_seed, _path, _pkmn).advances(_rolls);
      cache[_rolls] = lookup;
    }
    return lookup;
  }

  set rolls(int rolls) {
    _rolls = rolls;
    notifyListeners();
  }

  updateAdvances() {
    // rolls changed
    notifyListeners();
  }

  String pathDescription() => _path.join("|");

  MassOutbreakSearchResultState(this._seed, this._path, this._rolls, this._pkmn);

  int get rolls => _rolls;

  PokedexEntry get pkmn => _pkmn;

  List<int> get path => _path;

  int get seed => _seed;


}

class ExpandableToggle extends ChangeNotifier {
  Map<int, bool> _value = {};
  bool initial;

  ExpandableToggle(this.initial);

  bool value(int i) {
    return _value[i] ?? initial;
  }

  void toggle(int i) {
    _value[i] = !value(i);
    notifyListeners();
  }

  static Widget wrap(Widget Function(ExpandableToggle) widget, {bool initial = false}) {
    return ChangeNotifierProvider(
      create: (context) => ExpandableToggle(initial),
      child: Consumer<ExpandableToggle>(
        builder: (context, value, child) {
          return widget(value);
        },
      ),
    );
  }
}

class BooleanToggle extends ChangeNotifier {
  bool _value;

  BooleanToggle(this._value);

  bool get value => _value;

  void toggle() {
    _value = !_value;
    notifyListeners();
  }

  static Widget wrap(Widget Function(BooleanToggle) widget, {bool initial = false}) {
    return ChangeNotifierProvider(
      create: (context) => BooleanToggle(initial),
      child: Consumer<BooleanToggle>(
        builder: (context, value, child) {
          return widget(value);
        },
      ),
    );
  }
}

IconData genderSymbol(String gender) {
  if (gender == "M") {
    return FontAwesomeIcons.mars;
  } else if (gender == "F") {
    return FontAwesomeIcons.venus;
  }
  return FontAwesomeIcons.genderless;
}

class MassOutbreakSearchResult extends StatelessWidget {
  const MassOutbreakSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchResults = ModalRoute.of(context)!.settings.arguments as SearchResult;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return MassOutbreakSearchResultState(searchResults.seed, searchResults.path, searchResults.rolls, searchResults.pkmn);
        }),
        ChangeNotifierProvider(create: (context) {
          return MassOutbreakRollsState(rolls: searchResults.rolls);
        },)
      ],
      child: Builder(builder: (context) {
        var searchResultState = Provider.of<MassOutbreakSearchResultState>(context, listen: true);
        return Scaffold(
          appBar: AppBar(
            title: Text(searchResultState.pathDescription()),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/sprites/" + searchResultState.pkmn.nationalDexNumber.toString().padLeft(3, "0") + ".png"),
                        Text(
                          searchResultState.pkmn.pokemon,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                    Consumer<MassOutbreakRollsState>(builder: (context, rollsState, _) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return ToggleButtons(
                            constraints: BoxConstraints.expand(
                              width: constraints.maxWidth / 3 - (3 + 1.0) / 3,
                              height: 35,
                            ),
                            children: const [
                              Text("Complete"),
                              Text("Perfect"),
                              Text("Shiny Charm"),
                            ],
                            onPressed: (i) {
                              rollsState.toggleDexCompletion(i);
                              Provider.of<MassOutbreakSearchResultState>(context, listen: false).rolls = rollsState.rolls;
                            },
                            isSelected: rollsState.dexCompletion,
                          );
                        },
                      );
                    }),
                    Builder(builder: (context) {
                      var state = context.watch<MassOutbreakSearchResultState>();
                      return ExpandableToggle.wrap((p0) {
                        return ExpansionPanelList(
                          expansionCallback: (panelIndex, isExpanded) {
                            p0.toggle(panelIndex);
                          },
                          children: [
                            ...state.advances.mapIndexed((i, e) {
                              return ExpansionPanel(
                                isExpanded: p0.value(i),
                                headerBuilder: (context, _) {
                                  return ListTile(
                                    title: Text("Advance: ${i + 1}"),
                                    subtitle: actionDescription(e.actions),
                                  );
                                },
                                body: Column(
                                  children: e.reseeds
                                      .expand((e) =>
                                  [
                                    ListTile(
                                      title: Text(e.groupSeed),
                                    ),
                                    ...e.spawns.map(
                                          (e) {
                                        return BooleanToggle.wrap(
                                              (boolToggle) {
                                            return ListTile(
                                              leading: FaIcon(genderSymbol(e.gender)),
                                              title: Text(
                                                "${e.evs} ${e.nature}" + (e.shiny ? " shiny" : "") + (e.alpha ? " alpha" : ""),
                                                style: TextStyle(decoration: boolToggle.value ? TextDecoration.lineThrough : TextDecoration.none),
                                              ),
                                              onTap: () {
                                                boolToggle.toggle();
                                              },
                                            );
                                          },
                                          initial: false,
                                        );
                                      },
                                    )
                                  ])
                                      .toList(),
                                ),
                              );
                            }),
                          ],
                          // children: [Column()],
                        );
                      });
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Text? actionDescription(List<int> actions) {
    if (actions.isEmpty) {
      return null;
    }
    return Text(actions.map((act) {
      if (act > 0) {
        return "Catch $act";
      } else {
        return "Battle $act";
      }
    }).join(", "));
  }
}
