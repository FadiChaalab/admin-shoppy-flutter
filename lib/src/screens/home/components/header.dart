import 'package:admin_shop/src/components/custom_icon_button.dart';
import 'package:admin_shop/src/components/image_profile.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/screens/home/components/language_drop_down.dart';
import 'package:admin_shop/src/screens/home/components/search_bar.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerModel>(context);
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 70,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ResponsiveLayout.isMobile(context)
              ? CustomIconButton(
                  icon: 'assets/icons/Category.svg',
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              : const SizedBox(),
          Row(
            children: [
              ResponsiveLayout.currentWidth(context) < 740
                  ? CustomIconButton(
                      icon: 'assets/icons/Search.svg',
                      onTap: () {},
                    )
                  : const SearchBar(),
              const SizedBox(width: kDefaultPadding),
              ResponsiveLayout.isMobile(context)
                  ? const SizedBox()
                  : const LanguageDropDown(),
              ResponsiveLayout.isMobile(context)
                  ? const SizedBox()
                  : const SizedBox(width: kDefaultPadding / 2),
              CustomIconButton(
                icon: 'assets/icons/notification.svg',
                onTap: () {},
              ),
              const SizedBox(width: kDefaultPadding / 2),
              ImageProfile(
                width: 56,
                onTap: () {
                  drawer.changeScreen(8);
                },
              ),
              const SizedBox(width: kDefaultPadding / 2),
              CustomIconButton(
                icon: 'assets/icons/Settings.svg',
                onTap: () {
                  drawer.changeScreen(5);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
