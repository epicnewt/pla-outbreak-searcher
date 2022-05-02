import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchButton extends StatelessWidget {
  final void Function()? onPressed;

  const SearchButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Search"),
          SizedBox.fromSize(size: const Size(5, 0)),
          const FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            size: 12,
          )
        ],
      ),
    );
  }
}
