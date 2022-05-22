import 'package:admin_shop/src/components/footer.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/screens/calendar/calendar_screen.dart';
import 'package:admin_shop/src/screens/dashboard/dashboard_screen.dart';
import 'package:admin_shop/src/screens/home/components/header.dart';
import 'package:admin_shop/src/screens/orders/orders_screen.dart';
import 'package:admin_shop/src/screens/products/add_product.dart';
import 'package:admin_shop/src/screens/products/edit_product_screen.dart';
import 'package:admin_shop/src/screens/products/products.dart';
import 'package:admin_shop/src/screens/profile/profile_screen.dart';
import 'package:admin_shop/src/screens/settings/settings_screen.dart';
import 'package:admin_shop/src/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideView extends StatefulWidget {
  const SideView({Key? key}) : super(key: key);

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screens = [
      const DashboardScreen(),
      const CalendarScreen(),
      const UsersScreen(),
      const OrdersScreen(),
      const ProductsScreen(),
      const SettingsScreen(),
      const AddProductScreen(),
      const EditProductScreen(),
      const ProfileScreen(),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Consumer<DrawerModel>(
              builder: (context, drawer, _) {
                return _screens[drawer.currentScreen];
              },
            ),
            const Positioned(
              height: 70,
              top: 0,
              right: 0,
              left: 0,
              child: Header(),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}
