import 'package:admin_shop/src/components/custom_leading_icon.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String prefixIcon;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;
  final int? maxLines;
  final String? initialValue;
  const CustomTextFormField(
      {Key? key,
      this.controller,
      required this.hintText,
      required this.onChanged,
      required this.onSaved,
      required this.prefixIcon,
      required this.keyboardType,
      required this.validator,
      this.maxLines = 1,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? error;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 14),
      initialValue: widget.initialValue,
      controller: widget.controller,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
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
      ),
    );
  }
}
