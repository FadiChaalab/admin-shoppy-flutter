import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/db/products_repo.dart';
import 'package:admin_shop/src/screens/products/components/form_update_product.dart';
import 'package:admin_shop/src/screens/products/components/products_specification.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _productsRepo = ProductRepository();
  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerModel>(context, listen: false);
    deleteProduct() async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        await _productsRepo.deleteProduct(drawer.product.id).then(
          (value) {
            drawer.changeScreen(4);
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

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const SizedBox(height: kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeadlineTitle(title: 'Edit product'),
              Row(
                children: [
                  DefaultButton(
                    color: kDangerColor,
                    width: 84,
                    radius: 8,
                    height: 36,
                    fontSize: 14,
                    isUpper: false,
                    text: 'Delete',
                    press: () async {
                      await deleteProduct();
                    },
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  DefaultButton(
                    width: 84,
                    radius: 8,
                    height: 36,
                    fontSize: 14,
                    isUpper: false,
                    text: 'Go back',
                    press: () {
                      drawer.changeScreen(4);
                    },
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: [
              const SubTitle(title: 'Shoppy'),
              const SizedBox(width: kDefaultPadding / 2),
              const ArrowWidget(),
              const SizedBox(width: kDefaultPadding / 2),
              Row(
                children: const [
                  SubTitle(title: 'Edit product'),
                  SizedBox(width: kDefaultPadding / 2),
                  ManageProductDropDown(),
                ],
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Consumer<DrawerModel>(builder: (context, controller, _) {
            return UpdateProductForm(product: controller.product);
          }),
          const SizedBox(height: kDefaultPadding * 5),
        ],
      ),
    );
  }
}
