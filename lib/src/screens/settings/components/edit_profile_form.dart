import 'package:admin_shop/src/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:admin_shop/src/components/custom_leading_icon.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String? first;
  String? last;
  String? phone;
  String? addrese;
  String? age;

  updateUserInformation() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.updateUserInformation(
          first!, last!, addrese!, phone!, age!);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: buildFirstFormField(),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 3,
                child: buildLastFormField(),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: buildPhoneFormField(),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 3,
                child: buildAgeFormField(),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          buildAddreseFormField(),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1400),
            ),
            child: DefaultButton(
              width: 134,
              height: 40,
              radius: 8,
              text: AppLocalizations.of(context)!.updateButton,
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await updateUserInformation();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddreseFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 1200),
      ),
      child: Consumer<UserModel?>(builder: (context, user, _) {
        return TextFormField(
          initialValue: user?.addrese ?? '',
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.streetAddress,
          onSaved: (newValue) => addrese = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                error = null;
              });
            }
            if (value.length >= 3) {
              setState(() {
                error = null;
              });
            }
            if (value.length <= 40) {
              setState(() {
                error = null;
              });
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                error = AppLocalizations.of(context)!.addresenull;
              });
            } else if (value.length < 3) {
              setState(() {
                error = AppLocalizations.of(context)!.shorterror;
              });
            } else if (value.length > 40) {
              setState(() {
                error = AppLocalizations.of(context)!.addreselongerror;
              });
            }
            return error;
          },
          decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            labelStyle: const TextStyle(
              color: kTextColor,
              fontSize: 14,
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
              color: kTextColor,
            ),
            hintText: AppLocalizations.of(context)!.hintAddrese,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: const CustomLeadingIcon(
              svgIcon: "assets/icons/Location.svg",
              color: kTextColor,
            ),
          ),
        );
      }),
    );
  }

  Widget buildPhoneFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 800),
      ),
      child: Consumer<UserModel?>(builder: (context, user, _) {
        return TextFormField(
          initialValue: user?.phone?.toString() ?? '',
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.phone,
          onSaved: (newValue) => phone = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                error = null;
              });
            }
            if (value.length == 8) {
              setState(() {
                error = null;
              });
            }
            if (phoneValidatorRegExp.hasMatch(value)) {
              setState(() {
                error = null;
              });
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                error = AppLocalizations.of(context)!.shorterror;
              });
            } else if (value.length < 8 || value.length > 8) {
              setState(() {
                error = AppLocalizations.of(context)!.phonenull;
              });
            } else if (!phoneValidatorRegExp.hasMatch(value)) {
              setState(() {
                error = AppLocalizations.of(context)!.phoneerror;
              });
            }
            return error;
          },
          decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            labelStyle: const TextStyle(
              color: kTextColor,
              fontSize: 14,
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
              color: kTextColor,
            ),
            hintText: AppLocalizations.of(context)!.hintPhone,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: const CustomLeadingIcon(
              svgIcon: "assets/icons/Call.svg",
              color: kTextColor,
            ),
          ),
        );
      }),
    );
  }

  Widget buildAgeFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 1000),
      ),
      child: Consumer<UserModel?>(builder: (context, user, _) {
        return TextFormField(
          initialValue: user?.age?.toString() ?? '',
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.number,
          onSaved: (newValue) => age = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                error = null;
              });
            }
            if (int.parse(value) >= 7 && int.parse(value) <= 80) {
              setState(() {
                error = null;
              });
            }
            if (phoneValidatorRegExp.hasMatch(value)) {
              setState(() {
                error = null;
              });
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                error = AppLocalizations.of(context)!.agenull;
              });
            } else if (int.parse(value) < 7 || int.parse(value) > 80) {
              setState(() {
                error = AppLocalizations.of(context)!.ageerror;
              });
            } else if (!phoneValidatorRegExp.hasMatch(value)) {
              setState(() {
                error = AppLocalizations.of(context)!.invalidAge;
              });
            }
            return error;
          },
          decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            labelStyle: const TextStyle(
              color: kTextColor,
              fontSize: 14,
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
              color: kTextColor,
            ),
            hintText: AppLocalizations.of(context)!.hintAge,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: const CustomLeadingIcon(
              svgIcon: "assets/icons/Calendar.svg",
              color: kTextColor,
            ),
          ),
        );
      }),
    );
  }

  Widget buildLastFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 600),
      ),
      child: Consumer<UserModel?>(builder: (context, user, _) {
        return TextFormField(
          initialValue: user?.lastName ?? '',
          style: const TextStyle(fontSize: 14),
          onSaved: (newValue) => last = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                error = null;
              });
            }
            if (value.length >= 3) {
              setState(() {
                error = null;
              });
            }
            if (value.length <= 14) {
              setState(() {
                error = null;
              });
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                error = AppLocalizations.of(context)!.lastnull;
              });
            } else if (value.length < 3) {
              setState(() {
                error = AppLocalizations.of(context)!.shorterror;
              });
            } else if (value.length > 14) {
              setState(() {
                error = AppLocalizations.of(context)!.longerror;
              });
            }
            return error;
          },
          decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            labelStyle: const TextStyle(
              color: kTextColor,
              fontSize: 14,
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
              color: kTextColor,
            ),
            hintText: AppLocalizations.of(context)!.hintLast,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: const CustomLeadingIcon(
              svgIcon: "assets/icons/User.svg",
              color: kTextColor,
            ),
          ),
        );
      }),
    );
  }

  Widget buildFirstFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 400),
      ),
      child: Consumer<UserModel?>(builder: (context, user, _) {
        return TextFormField(
          initialValue: user?.firstName ?? '',
          style: const TextStyle(fontSize: 14),
          onSaved: (newValue) => first = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                error = null;
              });
            }
            if (value.length >= 3) {
              setState(() {
                error = null;
              });
            }
            if (value.length <= 14) {
              setState(() {
                error = null;
              });
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                error = AppLocalizations.of(context)!.firstnull;
              });
            } else if (value.length < 3) {
              setState(() {
                error = AppLocalizations.of(context)!.shorterror;
              });
            } else if (value.length > 14) {
              setState(() {
                error = AppLocalizations.of(context)!.longerror;
              });
            }
            return error;
          },
          decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            labelStyle: const TextStyle(
              color: kTextColor,
              fontSize: 14,
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
              color: kTextColor,
            ),
            hintText: AppLocalizations.of(context)!.hintFirst,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: const CustomLeadingIcon(
              svgIcon: "assets/icons/User.svg",
              color: kTextColor,
            ),
          ),
        );
      }),
    );
  }
}
