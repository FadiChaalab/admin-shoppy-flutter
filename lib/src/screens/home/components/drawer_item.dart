import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback onTap;
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: ResponsiveLayout.isTablet(context) ? title : '',
      child: ListTile(
        selected: isActive,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 6,
        ),
        selectedTileColor: const Color(0xFF383b4e),
        onTap: onTap,
        leading: ResponsiveLayout.isDesktop(context) ||
                Scaffold.of(context).isDrawerOpen
            ? SvgPicture.asset(
                icon,
                height: 18,
                color: isActive
                    ? const Color(0xFFb4c9de)
                    : const Color(0xFF8699ad),
              )
            : null,
        title: ResponsiveTitle(title: title, isActive: isActive, icon: icon),
      ),
    );
  }
}

class ResponsiveTitle extends StatelessWidget {
  final String title;
  final bool isActive;
  final String icon;
  const ResponsiveTitle(
      {Key? key,
      required this.title,
      required this.isActive,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      return Text(
        title,
        style: Theme.of(context).textTheme.caption!.copyWith(
              color:
                  isActive ? const Color(0xFFb4c9de) : const Color(0xFF8699ad),
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
            ),
      );
    } else {
      if (!ResponsiveLayout.isDesktop(context)) {
        return SvgPicture.asset(
          icon,
          height: 18,
          color: isActive ? const Color(0xFFb4c9de) : const Color(0xFF8699ad),
        );
      } else {
        return Text(
          title,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: isActive
                    ? const Color(0xFFb4c9de)
                    : const Color(0xFF8699ad),
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
              ),
        );
      }
    }
  }
}
