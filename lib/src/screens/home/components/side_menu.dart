import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/screens/home/components/drawer_item.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF333547),
      elevation: 0,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<DrawerModel>(builder: (context, drawer, _) {
          return Column(
            children: [
              const SizedBox(height: kDefaultPadding * 2),
              Center(
                child: AnimatedSwitcher(
                  duration: kDefaultAnimationDuration,
                  child: ResponsiveLayout.isTablet(context)
                      ? Image.asset(
                          'assets/images/logo.png',
                          height: 20,
                        )
                      : Image.asset(
                          'assets/images/logo-light.png',
                          height: 84,
                          width: 84,
                        ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 5),
              DrawerListTile(
                isActive: drawer.currentScreen == 0,
                title: 'Dashboard',
                icon: 'assets/icons/Home.svg',
                onTap: () {
                  drawer.changeScreen(0);
                },
              ),
              DrawerListTile(
                isActive: drawer.currentScreen == 1,
                title: 'Calendar',
                icon: 'assets/icons/Calendar.svg',
                onTap: () {
                  drawer.changeScreen(1);
                },
              ),
              DrawerListTile(
                isActive: drawer.currentScreen == 2,
                title: 'Users',
                icon: 'assets/icons/User-2.svg',
                onTap: () {
                  drawer.changeScreen(2);
                },
              ),
              DrawerListTile(
                isActive: drawer.currentScreen == 3,
                title: 'Orders',
                icon: 'assets/icons/Shop.svg',
                onTap: () {
                  drawer.changeScreen(3);
                },
              ),
              DrawerListTile(
                isActive: drawer.currentScreen == 4,
                title: 'Products',
                icon: 'assets/icons/Paper.svg',
                onTap: () {
                  drawer.changeScreen(4);
                },
              ),
              DrawerListTile(
                isActive: drawer.currentScreen == 5,
                title: 'Settings',
                icon: 'assets/icons/Settings.svg',
                onTap: () {
                  drawer.changeScreen(5);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
