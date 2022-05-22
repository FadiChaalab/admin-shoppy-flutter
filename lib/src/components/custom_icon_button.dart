import 'package:admin_shop/src/components/hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hover(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
