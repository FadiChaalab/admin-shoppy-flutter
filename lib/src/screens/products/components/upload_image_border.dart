import 'dart:typed_data';

import 'package:admin_shop/src/components/hover.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UploadImageBorder extends StatelessWidget {
  final VoidCallback onTap;
  final ValueListenable<bool> isUploaded;
  final ValueListenable<Uint8List?> image;
  const UploadImageBorder({
    Key? key,
    required this.onTap,
    required this.isUploaded,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isUploaded.value && image.value != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                image.value!,
                fit: BoxFit.cover,
                height: 60,
                width: 124,
              ),
            )
          : Hover(
              child: DottedBorder(
                strokeWidth: 1.5,
                dashPattern: const [8, 8],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                color: kSkipShadeThGradientColor,
                child: SizedBox(
                  height: 60,
                  width: 124,
                  child: Center(
                    child: Text(
                      'upload image',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: kSkipShadeThGradientColor),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
