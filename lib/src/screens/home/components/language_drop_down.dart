import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        focusColor: Theme.of(context).cardColor,
      ),
      child: DropdownButton<int>(
        focusColor: Theme.of(context).cardColor,
        value: _selectedIndex,
        underline: Container(),
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF495057),
        ),
        icon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            'assets/icons/arrow-down-2.svg',
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        items: [
          DropdownMenuItem(
            value: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/flag-united-kingdom.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Text(
                    AppLocalizations.of(context)!.englishLanguage,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
          DropdownMenuItem(
            value: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/flag-france.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Text(
                    AppLocalizations.of(context)!.frenchLanguage,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedIndex = value;
            });
          }
        },
        onTap: () {},
      ),
    );
  }
}
