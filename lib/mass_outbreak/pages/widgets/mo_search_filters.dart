import 'package:flutter/material.dart';

class MOSearchFilters extends StatelessWidget {
  final Function(bool shiny, bool alpha, bool male, bool female, bool multimatch) onChange;
  final bool shiny;
  final bool alpha;
  final bool male;
  final bool female;
  final bool multimatch;

  const MOSearchFilters(
      {Key? key, required this.onChange, required this.shiny, required this.alpha, required this.male, required this.female, required this.multimatch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Row(
            children: [
              const Expanded(child: Text("Shiny")),
              Switch.adaptive(
                value: shiny,
                onChanged: (v) {
                  onChange(!shiny, alpha, male, female, multimatch);
                },
              )
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text("Alpha")),
              Switch.adaptive(
                value: alpha,
                onChanged: (v) {
                  onChange(shiny, !alpha, male, female, multimatch);
                },
              )
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text("Male")),
              Switch.adaptive(
                value: male,
                onChanged: (v) {
                  onChange(shiny, alpha, !male, female || male, multimatch);
                },
              )
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text("Female")),
              Switch.adaptive(
                value: female,
                onChanged: (v) {
                  onChange(shiny, alpha, male || female, !female, multimatch);
                },
              )
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text("Multimatch")),
              Switch.adaptive(
                value: multimatch,
                onChanged: (v) {
                  onChange(shiny, alpha, male, female, !multimatch);
                },
              )
            ],
          ),
        ],
      );
    });
  }
}
