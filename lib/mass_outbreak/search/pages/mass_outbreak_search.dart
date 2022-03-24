import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/state/mass_outbreak_filter_state.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/state/mass_outbreak_information_state.dart';
import 'package:mmo_searcher/mass_outbreak/search/pages/state/mass_outbreak_rolls_state.dart';
import 'package:mmo_searcher/mass_outbreak/search/dummy/dummy_mass_outbreak_searcher.dart';
import 'package:mmo_searcher/mass_outbreak/search/model/mass_outbreak_searcher.dart';
import 'package:provider/provider.dart';

MultiProvider connect(MassOutbreakSearcher service, {Widget? child}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MassOutbreakInformationState()),
      ChangeNotifierProvider(create: (context) => MassOutbreakRollsState()),
      ChangeNotifierProvider(create: (context) => MassOutbreakFilterState()),
      Provider.value(value: service)
    ],
    child: Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("MO Searcher"),
        actions: [
          Consumer<MassOutbreakInformationState>(
            builder: (context, moInfo, _) {
              if (moInfo.loading) {
                return IconButton(
                  onPressed: () {},
                  icon: const CircularProgressIndicator(
                    value: null,
                    color: Colors.white,
                    semanticsLabel: "loading seed info",
                  ),
                );
              }

              return IconButton(
                onPressed: () {
                  Provider.of<MassOutbreakInformationState>(context, listen: false).refreshNotification(
                    Provider.of<MassOutbreakSearcher>(context, listen: false).getMassOutbreakInformation(),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.plug),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<MassOutbreakInformationState>(
          builder: (context, moInfo, _) {
            String data =  moInfo.getPokemon()?.pokemon ?? '???';
            return Column(
              children: <Widget>[
                Row(
                  children: [
                    ...(moInfo.massOutbreakInformation.species == -1
                        ? [const FaIcon(FontAwesomeIcons.circleQuestion, size: 48 + 8,)]
                        : [
                            Image.asset("assets/sprites/" + moInfo.massOutbreakInformation.species.toString().padLeft(3, "0") + ".png"),
                            Text(
                              data,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ]),
                    const Spacer(),
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Provider.of<MassOutbreakFilterState>(context, listen: false).toggleDisplay();
                        },
                        icon: const FaIcon(FontAwesomeIcons.filter),
                      );
                    }),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: TextField(
                    // obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'seed',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: TextField(
                    // obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'spawns',
                    ),
                  ),
                ),
                Consumer<MassOutbreakRollsState>(builder: (context, rolls, _) {
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
                          rolls.toggleDexCompletion(i);
                        },
                        isSelected: rolls.dexCompletion,
                      );
                    },
                  );
                }),
                Consumer<MassOutbreakFilterState>(
                  builder: (context, filters, child) {
                    return Column(
                      children: [
                        if (filters.show) ...[
                          Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.star),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Shiny"),
                              ),
                              const Spacer(),
                              Switch.adaptive(
                                value: filters.shiny,
                                onChanged: (v) {
                                  filters.shiny = v;
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.faceAngry),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Alpha"),
                              ),
                              const Spacer(),
                              Switch.adaptive(
                                value: filters.alpha,
                                onChanged: (v) {
                                  filters.alpha = v;
                                },
                              )
                            ],
                          ),
                          Consumer<MassOutbreakInformationState>(
                            builder: (context, mo, _) {
                              if (mo.getPokemon()?.isGenderFixed() ?? false) {
                                return Column();
                              }
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      const FaIcon(FontAwesomeIcons.mars),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("Male"),
                                      ),
                                      const Spacer(),
                                      Switch.adaptive(
                                        value: filters.male,
                                        onChanged: (v) {
                                          filters.male = v;
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const FaIcon(FontAwesomeIcons.venus),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("Female"),
                                      ),
                                      const Spacer(),
                                      Switch.adaptive(
                                        value: filters.female,
                                        onChanged: (v) {
                                          filters.female = v;
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }
                          ),
                        ] else
                          ...[]
                      ],
                    );
                  },
                ),
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
            );
          },
        ),
      ),
    ),
  );
}

var dummyMassOutbreakSearch = connect(DummyMassOutbreakSearcher());
