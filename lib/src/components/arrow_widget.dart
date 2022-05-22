import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowWidget extends StatelessWidget {
  const ArrowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/arrow-right.svg',
      color: const Color(0xFF6c757d),
    );
  }
}
