import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PokemonSprite extends StatelessWidget {
  final int dexNumber;
  final bool shiny;
  final bool? checked;
  final String? form;
  final bool alpha;

  const PokemonSprite({Key? key, required this.dexNumber, this.shiny = false, this.checked, this.form, this.alpha = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      "assets/sprites/" + dexNumber.toString().padLeft(3, "0") + (form == null ? "" : "-$form") + (shiny ? "-shiny.png" : ".png"),
      width: 56,
      height: 56,
    );

    return Stack(children: [
      Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Color.fromARGB(50, 0, 0, 0), shape: BoxShape.circle),
          width: 40,
          height: 40,
        ),
        image,
      ...[
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
        ),
      ].where((element) => checked ?? false),
      ...[Padding(
        padding: EdgeInsets.only(top: 45 - (alpha ? 12 : 0) - 5, left: 45 - 5),
        child: Container(
          width: 5 * 2,
          height: 5 * 2,
          child: CustomPaint(painter: ShinyLogoPainter())),
      )].where((element) => shiny),
      ...[Padding(
        padding: const EdgeInsets.only(top: 45 - 5, left: 45 - 5),
        child: Container(
          width: 5 * 2,
          height: 5 * 2,
          child: CustomPaint(painter: AlphaLogoPainter())),
      )].where((element) => alpha)
    ]);
  }
}

class AlphaLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        min(size.width / 2, size.height / 2),
        Paint()
          ..style = PaintingStyle.fill
          ..color = Color.fromARGB(255, 233, 94, 84));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ShinyLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        min(size.width / 2, size.height / 2),
        Paint()
          ..style = PaintingStyle.fill
          ..color = Color.fromARGB(255, 7, 76, 179));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
