import 'package:flutter/material.dart';

class Headline2Title extends StatelessWidget {
  final String title;
  const Headline2Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String title;
  const SubTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6c757d),
          ),
    );
  }
}
