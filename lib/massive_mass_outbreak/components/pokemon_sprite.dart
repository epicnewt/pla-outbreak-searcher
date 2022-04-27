import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mmo_searcher/pokedex/pokedex.dart';

class PokemonSprite extends StatelessWidget {
  final int dexNumber;

  const PokemonSprite({Key? key, required this.dexNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/sprites/" + dexNumber.toString().padLeft(3, "0") + ".png",
      width: 56,
      height: 56,
    );
  }
}
