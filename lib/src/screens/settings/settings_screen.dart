import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/components/image_profile.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/controllers/locale_controller.dart';
import 'package:admin_shop/src/controllers/theme_controller.dart';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/models/user.dart';
import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/screens/settings/components/genral_settings_item.dart';
import 'package:admin_shop/src/screens/settings/components/language_item.dart';
import 'package:admin_shop/src/screens/settings/components/user_information_item.dart';
import 'package:admin_shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final _drawer = Provider.of<DrawerModel>(context, listen: false);
    signOut() async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        await _authService.signOut().then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const SignInScreen(),
              ),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              AppLocalizations.of(context)!.offline,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        );
      }
    }

    final _themeController =
        Provider.of<ThemeController>(context, listen: false);
    final _drawerController = Provider.of<DrawerModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const SizedBox(height: kDefaultPadding),
          const HeadlineTitle(title: 'Settings'),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: const [
              SubTitle(title: 'Shoppy'),
              SizedBox(width: kDefaultPadding / 2),
              ArrowWidget(),
              SizedBox(width: kDefaultPadding / 2),
              SubTitle(title: 'Settings'),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Row(
            children: [
              ImageProfile(
                icon: 'assets/icons/Edit.svg',
                width: 58,
                onTap: () {
                  _drawerController.changeScreen(8);
                },
              ),
              const SizedBox(width: kDefaultPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserModel?>(builder: (context, user, _) {
                    String username = user!.firstName! + ' ' + user.lastName!;
                    return HeadlineTitle(
                      title: AppLocalizations.of(context)!.greeting +
                          ', ' +
                          username,
                    );
                  }),
                  const SizedBox(height: kDefaultPadding / 4),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return Text(
                      user?.email ?? '',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    );
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Wrap(
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineTitle(title: AppLocalizations.of(context)!.account),
                  const SizedBox(height: kDefaultPadding),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return UserInformationItem(
                      title: AppLocalizations.of(context)!.firstTitle,
                      subtitle: user?.firstName ?? '',
                    );
                  }),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return UserInformationItem(
                      title: AppLocalizations.of(context)!.lastTitle,
                      subtitle: user?.lastName ?? '',
                    );
                  }),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return UserInformationItem(
                      title: AppLocalizations.of(context)!.ageTitle,
                      subtitle: user?.age.toString() ?? '',
                    );
                  }),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return UserInformationItem(
                      title: AppLocalizations.of(context)!.phoneTitle,
                      subtitle: user?.phone.toString() ?? '',
                    );
                  }),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return UserInformationItem(
                      title: AppLocalizations.of(context)!.addreseTitle,
                      subtitle: user?.addrese ?? '',
                    );
                  }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineTitle(title: AppLocalizations.of(context)!.personal),
                  const SizedBox(height: kDefaultPadding),
                  GenralSettingsItem(
                    title: AppLocalizations.of(context)!.languages,
                    icon: 'assets/icons/global.svg',
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          insetAnimationDuration: kDefaultAnimationDuration,
                          insetAnimationCurve: Curves.fastOutSlowIn,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FractionallySizedBox(
                              heightFactor: 0.46,
                              widthFactor: ResponsiveLayout.isMobile(context)
                                  ? 0.9
                                  : 0.4,
                              child: Column(
                                children: [
                                  const SizedBox(height: kDefaultPadding / 3),
                                  SizedBox(
                                    height: 134,
                                    child: Lottie.asset(
                                      'assets/json/translate.json',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                    ),
                                    child: Consumer<LocaleController>(
                                      builder: (context, controller, _) {
                                        return LanguageItem(
                                          language:
                                              AppLocalizations.of(context)!
                                                  .englishLanguage,
                                          flag:
                                              'assets/images/flag-united-kingdom.png',
                                          isSelected: controller.locale ==
                                              const Locale('en'),
                                          onTap: () {
                                            controller.changeLocale(
                                                const Locale('en'));
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: kDefaultPadding / 2),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                    ),
                                    child: Consumer<LocaleController>(
                                      builder: (context, controller, _) {
                                        return LanguageItem(
                                          language:
                                              AppLocalizations.of(context)!
                                                  .frenchLanguage,
                                          flag: 'assets/images/flag-france.png',
                                          isSelected: controller.locale ==
                                              const Locale('fr'),
                                          onTap: () {
                                            controller.changeLocale(
                                                const Locale('fr'));
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  GenralSettingsItem(
                    title: AppLocalizations.of(context)!.theme,
                    icon: 'assets/icons/bucket.svg',
                    onPress: () {
                      _themeController.toggleChangeTheme();
                    },
                  ),
                  GenralSettingsItem(
                    title: 'Notifications',
                    icon: 'assets/icons/Notification.svg',
                    onPress: () {},
                  ),
                  GenralSettingsItem(
                    title: AppLocalizations.of(context)!.logout,
                    icon: 'assets/icons/Logout.svg',
                    onPress: () {
                      _drawer.changeScreen(0);
                      signOut();
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 4),
        ],
      ),
    );
  }
}
