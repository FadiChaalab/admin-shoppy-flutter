import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StaticInfoCard extends StatelessWidget {
  final String title;
  final Color color;
  final String icon;
  final String subtitle;
  final String average;
  final double percent;
  const StaticInfoCard({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
    required this.subtitle,
    required this.average,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: const BoxDecoration(
        color: Color(0xFF626ED4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF7984DB).withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  icon,
                  color: const Color(0xFF38A4F8),
                ),
              ),
              const Icon(Icons.more_vert, color: Color(0xFFB0B6E9)),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(
            title,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: const Color(0xFFB0B6E9),
                  fontSize: 16,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          ProgressLine(
            color: kDarkPrimaryColor,
            percentage: percent.toInt(),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: const Color(0xFFB0B6E9)),
              ),
              Text(
                average,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: const Color(0xFFB0B6E9)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = kPrimaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1).withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFF38A4F8),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
