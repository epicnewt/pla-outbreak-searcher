import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchButton extends StatefulWidget {
  final Future Function()? onPressed;

  SearchButton({Key? key, this.onPressed}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (widget.onPressed == null) {
          return;
        }

        try {
          setState(() => loading = true);
          await widget.onPressed!();
        } finally {
          setState(() => loading = false);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Search"),
          SizedBox.fromSize(size: const Size(5, 0)),
          if (!loading)
            const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 12,
            ),
          if (loading)
            SizedBox.square(
              dimension: 12,
              child: CircularProgressIndicator(strokeWidth: 2, color: Theme.of(context).colorScheme.inversePrimary),
            )
        ],
      ),
    );
  }
}
