import 'package:flutter/material.dart';

class SimpleRoutedWidget<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T argument) builder;

  const SimpleRoutedWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = arguments(context);
    return builder(context, args);
  }

  T arguments(BuildContext context) => ModalRoute.of(context)!.settings.arguments as T;
}