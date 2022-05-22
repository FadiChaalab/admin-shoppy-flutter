import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 204,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          enabledBorder: outlineSearchInputBorder,
          focusedBorder: outlineSearchInputBorder,
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
          ),
          hintText: 'search...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(
              0,
              kDefaultPadding - 4,
              0,
              kDefaultPadding - 4,
            ),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
