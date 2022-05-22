import 'package:admin_shop/src/components/custom_password_form_field.dart';
import 'package:admin_shop/src/components/custom_text_form_field.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/screens/complete_profile/complete_profile_screen.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String? email;
  String? emailError;
  String? password;
  String? passwordError;
  String? repassword;
  String? repasswordError;
  String? match;

  signUp() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.signUpWithEmailAndPassword(email!, password!).then(
        (value) {
          if (value != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const CompleteProfileScreen(),
              ),
            );
          }
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            AppLocalizations.of(context)!.offline,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 400),
            ),
            child: CustomTextFormField(
              hintText: AppLocalizations.of(context)!.enteremail,
              onSaved: (newValue) => email = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    emailError = null;
                  });
                }
                if (emailValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    emailError = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    emailError = AppLocalizations.of(context)!.emailnull;
                  });
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    emailError = AppLocalizations.of(context)!.invalidemail;
                  });
                }
                return emailError;
              },
              keyboardType: TextInputType.emailAddress,
              prefixIcon: "assets/icons/Message.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 600),
            ),
            child: CustomPasswordFormField(
              hintText: AppLocalizations.of(context)!.enterpassword,
              prefixIcon: "assets/icons/Lock.svg",
              onSaved: (newValue) => password = newValue,
              onChanged: (value) {
                match = value;
                if (value.isNotEmpty) {
                  setState(() {
                    passwordError = null;
                  });
                }
                if (value.length >= 8) {
                  setState(() {
                    passwordError = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    passwordError = AppLocalizations.of(context)!.pwdnull;
                  });
                } else if (value.length < 8) {
                  setState(() {
                    passwordError = AppLocalizations.of(context)!.pwdshort;
                  });
                }
                return passwordError;
              },
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 800),
            ),
            child: CustomPasswordFormField(
              hintText: AppLocalizations.of(context)!.renterpwd,
              prefixIcon: "assets/icons/Lock.svg",
              onSaved: (newValue) => repassword = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    repasswordError = null;
                  });
                }
                if (value.length >= 8) {
                  setState(() {
                    repasswordError = null;
                  });
                }
                if (value == match) {
                  setState(() {
                    repasswordError = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    repasswordError = AppLocalizations.of(context)!.pwdnull;
                  });
                } else if (value.length < 8) {
                  setState(() {
                    repasswordError = AppLocalizations.of(context)!.pwdshort;
                  });
                } else if (value != match) {
                  setState(() {
                    repasswordError = AppLocalizations.of(context)!.nomatch;
                  });
                }
                return repasswordError;
              },
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1000),
            ),
            child: DefaultButton(
              text: AppLocalizations.of(context)!.signup,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  signUp();
                  if (_authService.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          _authService.errorMessage!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1200),
            ),
            child: Text(
              AppLocalizations.of(context)!.terms,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: kTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
