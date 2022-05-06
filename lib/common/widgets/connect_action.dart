import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnectAction extends StatefulWidget {
  final Future Function() onPress;

  const ConnectAction({Key? key, required this.onPress}) : super(key: key);

  @override
  State<ConnectAction> createState() => _ConnectActionState();
}

class _ConnectActionState extends State<ConnectAction> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () async {
            if (!isLoading) {
              setState((() => isLoading = true));
              try {
                await widget.onPress();
              } finally {
                setState((() => isLoading = false));
              }
            }
          },
          child: Center(
            child: Stack(
              children: [
                const FaIcon(FontAwesomeIcons.plug),
                if (isLoading)
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(top: 10, left: 5.5),
                    child: const CircularProgressIndicator(
                      // color: Colors.black,
                      strokeWidth: 2,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
