import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PokemonSprite extends StatelessWidget {
  final int dexNumber;
  final bool shiny;
  final bool? checked;
  final String? form;
  final bool alpha;
  final bool ghost;

  const PokemonSprite({Key? key, required this.dexNumber, this.shiny = false, this.checked, this.form, this.alpha = false, this.ghost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = ghost
        ? Image.asset(
            "assets/sprites/ghost-spawn.png",
            width: 56,
            height: 56,
          )
        : Image.asset(
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
      Container(
        width: 56,
        height: 56,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...[Container(width: 12, height: 12, child: CustomPaint(painter: AlphaLogoPainter()))].where((element) => alpha),
            ...[Container(width: 12, height: 12, child: CustomPaint(painter: ShinyLogoPainter()))].where((element) => shiny),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 1),
                    child: e,
                  ))
              .toList(),
        ),
      )
    ]);
  }
}

class AlphaLogoPainter extends CustomPainter {
  var colour = const Color.fromARGB(255, 233, 94, 84);

  final Paint _paint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color.fromARGB(255, 233, 94, 84);

  /// M 80.36 47.45 C 80.09 70.82 70.18 81.27 56.09 69 C 56.09 69 80.36 47.45 80.36 47.45 Z
  /// M 19 13.82 C 14.09 32.55 7 55.64 7 55.64 C 2.27 72.36 2.73 69 24.36 86.45 C 49.91 104.45 49.91 104.45 75.36 86.45 C 97.18 68.36 97.36 71.45 93.64 55.64 C 93.64 55.64 81.09 13.36 81.09 13.36 C 81.09 13.36 68.91 23.82 68.91 23.82 C 68.91 23.82 50.36 0 50.36 0 C 50.36 0 30.82 23.36 30.82 23.36 C 30.82 23.36 19.18 13.82 19 13.82 Z
  /// M 19.91 47.18 C 20.09 70.64 29.64 81.09 43.27 68.82 C 43.27 68.82 19.91 47.18 19.91 47.18 Z

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 100, size.height / 100);

    canvas.drawPath(
      Path.combine(
          PathOperation.difference,
          Path()
            ..moveTo(19, 13.82)
            ..cubicTo(14.09, 32.55, 7, 55.64, 7, 55.64)
            ..cubicTo(2.27, 72.36, 2.73, 69, 24.36, 86.45)
            ..cubicTo(49.91, 104.45, 49.91, 104.45, 75.36, 86.45)
            ..cubicTo(97.18, 68.36, 97.36, 71.45, 93.64, 55.64)
            ..cubicTo(93.64, 55.64, 81.09, 13.36, 81.09, 13.36)
            ..cubicTo(81.09, 13.36, 68.91, 23.82, 68.91, 23.82)
            ..cubicTo(68.91, 23.82, 50.36, 0, 50.36, 0)
            ..cubicTo(50.36, 0, 30.82, 23.36, 30.82, 23.36)
            ..cubicTo(30.82, 23.36, 19.18, 13.82, 19, 13.82),
          Path()
            ..moveTo(19.91, 47.18)
            ..cubicTo(20.09, 70.64, 29.64, 81.09, 43.27, 68.82)
            ..cubicTo(43.27, 68.82, 19.91, 47.18, 19.91, 47.18)
            ..moveTo(80.36, 47.45)
            ..cubicTo(80.09, 70.82, 70.18, 81.27, 56.09, 69)
            ..cubicTo(56.09, 69, 80.36, 47.45, 80.36, 47.45)),
      _paint,
    );

    // canvas.drawCircle(
    //     Offset(size.width / 2, size.height / 2),
    //     min(size.width / 2, size.height / 2),
    //     Paint()
    //       ..style = PaintingStyle.fill
    //       ..color = colour);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ShinyLogoPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color.fromARGB(255, 7, 76, 179);
  final Paint _white = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.white;
  // M 58 72 C 69 72 76 66 76 54 C 76 66 83 72 94 72 C 83 72 76 76 76 89 C 76 76 69 72 58 72 Z M 7 44 C 35 44 45 35 45 8 C 45 35 54 44 81 44 C 54 44 45 52 45 79 C 45 52 35 44 7 44 Z
  @override
  void paint(Canvas canvas, Size size) {
    // M 58 72 C 69 72 76 66 76 54 C 76 66 83 72 94 72 C 83 72 76 76 76 89 C 76 76 69 72 58 72 Z M 7 44 C 35 44 45 35 45 8 C 45 35 54 44 81 44 C 54 44 45 52 45 79 C 45 52 35 44 7 44 Z
    canvas.scale(size.width / 100, size.height / 100);

    canvas.drawPath(
        Path()
          ..moveTo(0, 8)
          ..lineTo(8, 0)
          ..lineTo(100 - 8, 0)
          ..lineTo(100, 8)
          ..lineTo(100, 100 - 8)
          ..lineTo(100 - 8, 100)
          ..lineTo(8, 100)
          ..lineTo(0, 100 - 8)
          ..lineTo(0, 0),
        _paint);

    canvas.drawCircle(const Offset(8.0, 8.0), 8.0, _paint);
    canvas.drawCircle(const Offset(100 - 8.0, 8.0), 8.0, _paint);
    canvas.drawCircle(const Offset(8.0, 100 - 8.0), 8.0, _paint);
    canvas.drawCircle(const Offset(100 - 8.0, 100 - 8.0), 8.0, _paint);

    canvas.drawPath(
      Path()
        ..moveTo(7, 44)
        ..cubicTo(35, 44, 45, 35, 45, 8)
        ..cubicTo(45, 35, 54, 44, 81, 44)
        ..cubicTo(54, 44, 45, 52, 45, 79)
        ..cubicTo(45, 52, 35, 44, 7, 44),
      _white,
    );
    canvas.drawPath(
      Path()
        ..moveTo(58, 72)
        ..cubicTo(69, 72, 76, 66, 76, 54)
        ..cubicTo(76, 66, 83, 72, 94, 72)
        ..cubicTo(83, 72, 76, 76, 76, 89)
        ..cubicTo(76, 76, 69, 72, 58, 72),
      _white,
    );

    // canvas.drawCircle(
    //     Offset(size.width / 2, size.height / 2),
    //     min(size.width / 2, size.height / 2),
    //     _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
