import 'package:admin_shop/src/components/custom_leading_icon.dart';
import 'package:admin_shop/src/components/custom_surfix_icon.dart';
import 'package:admin_shop/src/components/hover.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String prefixIcon;
  final void Function(String) onChanged;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;
  const CustomPasswordFormField(
      {Key? key,
      this.controller,
      required this.hintText,
      required this.onChanged,
      required this.onSaved,
      required this.prefixIcon,
      required this.validator})
      : super(key: key);

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  String? error;
  bool isSecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 14),
      controller: widget.controller,
      obscureText: isSecure,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: kTextColor,
        ),
        hintText: widget.hintText,
        prefixIcon: CustomLeadingIcon(
          svgIcon: widget.prefixIcon,
          color: kTextColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isSecure = !isSecure;
            });
          },
          child: Hover(
            child: AnimatedSwitcher(
              duration: kDefaultAnimationDuration,
              child: isSecure
                  ? const CustomSurffixIcon(
                      svgIcon: "assets/icons/Show.svg",
                      color: kTextColor,
                    )
                  : const CustomSurffixIcon(
                      svgIcon: "assets/icons/Hide.svg",
                      color: kTextColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
