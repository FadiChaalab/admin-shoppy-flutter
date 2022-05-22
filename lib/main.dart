import 'package:admin_shop/auth/secrets.dart';
import 'package:admin_shop/src/components/loading_screen.dart';
import 'package:admin_shop/src/controllers/category_controller.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/controllers/locale_controller.dart';
import 'package:admin_shop/src/controllers/orders_controller.dart';
import 'package:admin_shop/src/controllers/theme_controller.dart';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/db/orders.dart';
import 'package:admin_shop/src/db/products_repo.dart';
import 'package:admin_shop/src/models/order.dart';
import 'package:admin_shop/src/models/product.dart';
import 'package:admin_shop/src/models/user.dart';
import 'package:admin_shop/src/screens/home/home_screen.dart';
import 'package:admin_shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:admin_shop/src/services/locator.dart';
import 'package:admin_shop/src/theme/theme.dart';
import 'package:admin_shop/src/utils/connectivity.dart';
import 'package:admin_shop/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      await firebase_core.Firebase.initializeApp(
        options: const firebase_core.FirebaseOptions(
          apiKey: apiKey,
          authDomain: authDomain,
          projectId: projectId,
          storageBucket: storageBucket,
          messagingSenderId: messagingSenderId,
          appId: appId,
        ),
      );
    } else {
      await firebase_core.Firebase.initializeApp();
    }
    setUp();
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = AuthService();
    final _productsRepository = ProductRepository();
    final _orders = Orders();
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeController>(
            create: (_) => locator.get<ThemeController>(),
          ),
          ListenableProvider<DrawerModel>(
            create: (_) => locator.get<DrawerModel>(),
          ),
          ListenableProvider<LocaleController>(
            create: (_) => LocaleController(),
          ),
          ListenableProvider<CategoryController>(
            create: (_) => CategoryController(),
          ),
          ListenableProvider<OrdersController>(
            create: (_) => OrdersController(),
          ),
          StreamProvider<ConnectivityStatus>(
            create: (_) =>
                ConnectivityService().connectionStatusController.stream,
            initialData: ConnectivityStatus.offline,
          ),
          StreamProvider<UserModel?>.value(
            value: _authService.streamFirestoreUser(),
            initialData: null,
          ),
          StreamProvider<List<Product>?>.value(
            value: _productsRepository.getProducts(),
            initialData: null,
          ),
          StreamProvider<List<Order>?>.value(
            value: _orders.getOrders(),
            initialData: null,
          ),
          StreamProvider<List<UserModel?>?>.value(
            value: _authService.streamFirestoreUsers(),
            initialData: null,
          ),
        ],
        child: Consumer2<ThemeController, LocaleController>(
          builder: (context, controller, locale, _) {
            return MaterialApp(
              title: 'Shoppy',
              scrollBehavior: MyCustomScrollBehavior(),
              debugShowCheckedModeBanner: false,
              locale: locale.locale,
              theme: controller.darkMode ? darkTheme : lightTheme,
              home: const HomeController(),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            );
          },
        ),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        }
      },
    );
  }
}
