import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SvgPicture.asset(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      title: Text(title),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SvgPicture.asset(
          'assets/icons/arrow-right.svg',
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
