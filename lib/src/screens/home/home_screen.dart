import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/screens/home/components/side_menu.dart';
import 'package:admin_shop/src/screens/home/components/side_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveLayout.isMobile(context)
              ? const SizedBox()
              : SizedBox(
                  width: ResponsiveLayout.isDesktop(context) ? 240 : 70,
                  child: const SideMenu(),
                ),
          const Expanded(
            flex: 5,
            child: SideView(),
          ),
        ],
      ),
    );
  }
}
