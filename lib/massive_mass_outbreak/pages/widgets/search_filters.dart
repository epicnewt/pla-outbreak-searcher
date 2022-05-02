import 'package:flutter/material.dart';

class SearchFilters extends StatelessWidget {
  final Function(bool, bool, bool) onChange;
  final bool shiny;
  final bool alpha;
  final bool multimatch;

  const SearchFilters({Key? key, required this.onChange, required this.shiny, required this.alpha, required this.multimatch}) : super(key: key);

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
                  onChange(!shiny, alpha, multimatch);
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
                  onChange(shiny, !alpha, multimatch);
                },
              )
            ],
          ),
          // Row(
          //   children: [
          //     const Expanded(child: Text("Multimatch")),
          //     Switch.adaptive(
          //       value: multimatch,
          //       onChanged: (v) {
          //         onChange(shiny, alpha, !multimatch);
          //       },
          //     )
          //   ],
          // ),
        ],
      );
    });
  }
}
