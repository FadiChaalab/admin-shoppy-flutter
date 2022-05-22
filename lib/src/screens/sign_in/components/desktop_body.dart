import 'package:admin_shop/src/components/no_account_text.dart';
import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sign_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.025),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kDefaultPadding * 5),
                        FadeInDown(
                          child: Text(
                            AppLocalizations.of(context)!.welcome,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 2),
                        FadeInDown(
                          preferences: const AnimationPreferences(
                            offset: Duration(milliseconds: 200),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signinmethod,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: kTextColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveLayout.isTablet(context)
                      ? kDefaultPadding * 2
                      : kDefaultPadding * 5,
                ),
                children: [
                  const SizedBox(height: kDefaultPadding * 5),
                  const SignForm(),
                  SizedBox(height: 20.h),
                  FadeInDown(
                    preferences: const AnimationPreferences(
                      offset: Duration(milliseconds: 1200),
                    ),
                    child: const NoAccountText(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
