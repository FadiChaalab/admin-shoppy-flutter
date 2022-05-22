import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/screens/products/components/form_add_product.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const SizedBox(height: kDefaultPadding),
          const HeadlineTitle(title: 'Product'),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: const [
              SubTitle(title: 'Shoppy'),
              SizedBox(width: kDefaultPadding / 2),
              ArrowWidget(),
              SizedBox(width: kDefaultPadding / 2),
              SubTitle(title: 'Add Product'),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          const AddProductForm(),
          const SizedBox(height: kDefaultPadding * 5),
        ],
      ),
    );
  }
}
