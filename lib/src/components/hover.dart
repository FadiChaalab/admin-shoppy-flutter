import 'package:flutter/material.dart';

class Hover extends StatelessWidget {
  final Widget child;
  const Hover({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: child,
    );
  }
}
