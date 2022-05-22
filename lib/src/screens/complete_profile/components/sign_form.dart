import 'package:admin_shop/src/components/custom_text_form_field.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/models/user.dart';
import 'package:admin_shop/src/screens/success/success_screen.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String? first;
  String? errorFirst;
  String? last;
  String? errorLast;
  String? phone;
  String? errorPhone;
  String? addrese;
  String? errorAddrese;
  String? age;
  String? errorAge;

  Future createUserModel() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.getCurrentUser().then(
        (value) async {
          if (value != null) {
            await _authService
                .createUser(
              UserModel(
                uid: value.uid,
                email: value.email!,
                firstName: first,
                lastName: last,
                phone: int.parse(phone!),
                age: int.parse(age!),
                addrese: addrese,
              ),
            )
                .then(
              (value) {
                if (value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SuccessScreen(),
                    ),
                  );
                }
              },
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 400),
            ),
            child: CustomTextFormField(
              keyboardType: TextInputType.text,
              hintText: AppLocalizations.of(context)!.hintFirst,
              prefixIcon: "assets/icons/User.svg",
              onSaved: (newValue) => first = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorFirst = null;
                  });
                }
                if (value.length >= 3) {
                  setState(() {
                    errorFirst = null;
                  });
                }
                if (value.length <= 14) {
                  setState(() {
                    errorFirst = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    errorFirst = AppLocalizations.of(context)!.firstnull;
                  });
                } else if (value.length < 3) {
                  setState(() {
                    errorFirst = AppLocalizations.of(context)!.shorterror;
                  });
                } else if (value.length > 14) {
                  setState(() {
                    errorFirst = AppLocalizations.of(context)!.longerror;
                  });
                }
                return errorFirst;
              },
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 600),
            ),
            child: CustomTextFormField(
              keyboardType: TextInputType.text,
              onSaved: (newValue) => last = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorLast = null;
                  });
                }
                if (value.length >= 3) {
                  setState(() {
                    errorLast = null;
                  });
                }
                if (value.length <= 14) {
                  setState(() {
                    errorLast = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    errorLast = AppLocalizations.of(context)!.lastnull;
                  });
                } else if (value.length < 3) {
                  setState(() {
                    errorLast = AppLocalizations.of(context)!.shorterror;
                  });
                } else if (value.length > 14) {
                  setState(() {
                    errorLast = AppLocalizations.of(context)!.longerror;
                  });
                }
                return errorLast;
              },
              hintText: AppLocalizations.of(context)!.hintLast,
              prefixIcon: "assets/icons/User.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 800),
            ),
            child: CustomTextFormField(
              keyboardType: TextInputType.phone,
              onSaved: (newValue) => phone = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorPhone = null;
                  });
                }
                if (value.length == 8) {
                  setState(() {
                    errorPhone = null;
                  });
                }
                if (phoneValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    errorPhone = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    errorPhone = AppLocalizations.of(context)!.shorterror;
                  });
                } else if (value.length < 8 || value.length > 8) {
                  setState(() {
                    errorPhone = AppLocalizations.of(context)!.phonenull;
                  });
                } else if (!phoneValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    errorPhone = AppLocalizations.of(context)!.phoneerror;
                  });
                }
                return errorPhone;
              },
              hintText: AppLocalizations.of(context)!.hintPhone,
              prefixIcon: "assets/icons/Call.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1000),
            ),
            child: CustomTextFormField(
              keyboardType: TextInputType.number,
              onSaved: (newValue) => age = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorAge = null;
                  });
                }
                if (int.parse(value) >= 7 && int.parse(value) <= 80) {
                  setState(() {
                    errorAge = null;
                  });
                }
                if (phoneValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    errorAge = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    errorAge = AppLocalizations.of(context)!.agenull;
                  });
                } else if (int.parse(value) < 7 || int.parse(value) > 80) {
                  setState(() {
                    errorAge = AppLocalizations.of(context)!.ageerror;
                  });
                } else if (!phoneValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    errorAge = AppLocalizations.of(context)!.invalidAge;
                  });
                }
                return errorAge;
              },
              hintText: AppLocalizations.of(context)!.hintAge,
              prefixIcon: "assets/icons/Calendar.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1200),
            ),
            child: CustomTextFormField(
              keyboardType: TextInputType.streetAddress,
              onSaved: (newValue) => addrese = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorAddrese = null;
                  });
                }
                if (value.length >= 3) {
                  setState(() {
                    errorAddrese = null;
                  });
                }
                if (value.length <= 40) {
                  setState(() {
                    errorAddrese = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    errorAddrese = AppLocalizations.of(context)!.addresenull;
                  });
                } else if (value.length < 3) {
                  setState(() {
                    errorAddrese = AppLocalizations.of(context)!.shorterror;
                  });
                } else if (value.length > 40) {
                  setState(() {
                    errorAddrese =
                        AppLocalizations.of(context)!.addreselongerror;
                  });
                }
                return errorAddrese;
              },
              hintText: AppLocalizations.of(context)!.hintAddrese,
              prefixIcon: "assets/icons/Location.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1400),
            ),
            child: DefaultButton(
              text: AppLocalizations.of(context)!.continueButton,
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  createUserModel();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
