import 'package:admin_shop/src/components/hover.dart';
import 'package:admin_shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: kTextColor,
              ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SignInScreen(),
              ),
            );
          },
          child: Hover(
            child: Text(
              AppLocalizations.of(context)!.signin,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: kPrimaryColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
