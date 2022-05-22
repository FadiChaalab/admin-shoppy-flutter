import 'package:admin_shop/src/components/custom_text_form_field.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/components/no_account_text.dart';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  final _authService = AuthService();

  resetPassword() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.resetPass(email!).then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const SignInScreen(),
              ),
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Oops you are offline",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? error;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 400),
            ),
            child: CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  error = null;
                }
                if (emailValidatorRegExp.hasMatch(value)) {
                  error = null;
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  error = AppLocalizations.of(context)!.emailnull;
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  error = AppLocalizations.of(context)!.invalidemail;
                }
                return error;
              },
              hintText: AppLocalizations.of(context)!.enteremail,
              prefixIcon: "assets/icons/Message.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 600),
            ),
            child: DefaultButton(
              text: AppLocalizations.of(context)!.continueButton,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  resetPassword();
                }
              },
            ),
          ),
          SizedBox(height: 60.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 800),
            ),
            child: const NoAccountText(),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
