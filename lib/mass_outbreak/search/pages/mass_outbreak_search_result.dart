import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/search_result.dart';
import 'package:provider/provider.dart';

class Advance {
  List<int> actions;
  List<ReseedSet> reseeds;

  Advance(this.actions, this.reseeds);
}

class ReseedSet {
  String groupSeed;
  List<Spawn> spawns;

  ReseedSet(this.groupSeed, this.spawns);
}

class Spawn {
  String gender;
  String evs;
  String nature;

  Spawn(this.gender, this.evs, this.nature);
}

class MassOutbreakSearchResultState extends ChangeNotifier {
  BigInt _seed;
  List<int> _path;
  List<Advance> _advances;
  int _rolls = 26;

  List<Advance> get advances => _advances;

  rolls(int rolls) {
    _rolls = rolls;
  }

  updateAdvances() {
    // rolls changed
    notifyListeners();
  }

  String pathDescription() => _path.join("|");

  MassOutbreakSearchResultState(this._seed, this._path, this._rolls)
      : _advances = [
          Advance(
            [2],
            [
              ReseedSet("E21967CB3B73E5DA",
                  [Spawn("M", "333012", "Docile"), Spawn("F", "000000", "Lax"), Spawn("F", "003012", "Docile"), Spawn("M", "123012", "Docile")]),
              ReseedSet("E21967CB3B73E5DA", [Spawn("M", "333012", "Docile"), Spawn("F", "000000", "Lax")]),
            ],
          ),
          Advance(
            [],
            [
              ReseedSet("E21967CB3B73E5DA",
                  [Spawn("M", "333012", "Docile"), Spawn("F", "000000", "Lax"), Spawn("F", "003012", "Docile"), Spawn("M", "123012", "Docile")]),
              ReseedSet("E21967CB3B73E5DA", [Spawn("G", "333012", "Docile"), Spawn("F", "000000", "Lax")]),
            ],
          ),
        ];
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
    return ChangeNotifierProvider(
      create: (context) {
        return MassOutbreakSearchResultState(searchResults.seed, searchResults.path, searchResults.rolls);
      },
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Provider.of<MassOutbreakSearchResultState>(context, listen: true).pathDescription()),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
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
                                .expand((e) => [
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
                                                  "${e.evs} ${e.nature}",
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
