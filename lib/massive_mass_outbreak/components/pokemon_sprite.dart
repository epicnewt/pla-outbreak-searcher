import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PokemonSprite extends StatelessWidget {
  final int dexNumber;
  final bool shiny;
  final bool checked;

  const PokemonSprite({Key? key, required this.dexNumber, this.shiny = false, this.checked = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      "assets/sprites/" + dexNumber.toString().padLeft(3, "0") + (shiny ? "-shiny.png" : ".png"),
      width: 56,
      height: 56,
    );

    if (!checked) {
      return image;
    }

    return Stack(children: [
      image,
      Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Color.fromARGB(127, 0, 0, 0), shape: BoxShape.circle),
        width: 40,
        height: 40,
      ),
      const Padding(
        padding: EdgeInsets.all(16),
        child: FaIcon(
          FontAwesomeIcons.check,
          color: Colors.white,
        ),
      )
    ]);
  }
}
