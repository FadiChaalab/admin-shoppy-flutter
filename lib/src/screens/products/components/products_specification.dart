import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/db/products_repo.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ManageProductDropDown extends StatefulWidget {
  const ManageProductDropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageProductDropDown> createState() => _ManageProductDropDownState();
}

class _ManageProductDropDownState extends State<ManageProductDropDown> {
  final _productsRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        focusColor: const Color(0xFFf8f9fa),
      ),
      child: Consumer<DrawerModel>(builder: (context, drawer, _) {
        bool _newProduct = drawer.product.newProduct;
        bool _flashSales = drawer.product.flashSales;
        bool _bestSeller = drawer.product.bestSeller;
        bool _popular = drawer.product.popular;
        bool _blackMarket = drawer.product.blackMarket;
        bool _summerSales = drawer.product.summerSales;
        return PopupMenuButton(
          icon: SvgPicture.asset('assets/icons/arrow-down-2.svg'),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _newProduct,
                        onChanged: (v) {
                          setState(() {
                            _newProduct = v!;
                          });
                          if (_newProduct) {
                            _productsRepository.addProductToNew(drawer.product);
                          } else {
                            _productsRepository
                                .removeProductFromNew(drawer.product);
                          }
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      const Text(
                        'New',
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _flashSales,
                        onChanged: (v) {
                          setState(() {
                            _flashSales = v!;
                          });
                          if (_flashSales) {
                            _productsRepository
                                .addProductToFlashSales(drawer.product);
                          } else {
                            _productsRepository
                                .removeProductFromFlashSales(drawer.product);
                          }
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      const Text(
                        'Flash Sales',
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _bestSeller,
                        onChanged: (v) {
                          setState(() {
                            _bestSeller = v!;
                          });
                          if (_bestSeller) {
                            _productsRepository
                                .addProductToBestSeller(drawer.product);
                          } else {
                            _productsRepository
                                .removeProductFromBestSeller(drawer.product);
                          }
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      const Text(
                        'Best Seller',
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _popular,
                        onChanged: (v) {
                          setState(() {
                            _popular = v!;
                          });
                          if (_popular) {
                            _productsRepository
                                .addProductToPopular(drawer.product);
                          } else {
                            _productsRepository
                                .removeProductFromPopular(drawer.product);
                          }
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      const Text(
                        'Popular',
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _blackMarket,
                        onChanged: (v) {
                          setState(() {
                            _blackMarket = v!;
                          });
                          if (_blackMarket) {
                            _productsRepository
                                .addProductToBlackMarket(drawer.product);
                          } else {
                            _productsRepository
                                .removeProductFromBlackMarket(drawer.product);
                          }
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      const Text(
                        'Black Friday',
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _summerSales,
                        onChanged: (v) {
                          setState(() {
                            _summerSales = v!;
                          });
                          if (_summerSales) {
                            _productsRepository
                                .addProductToSummerSales(drawer.product);
                          } else {
                            _productsRepository
                                .removeProductFromSummerSales(drawer.product);
                          }
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      const Text(
                        'Summer Sales',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
        );
      }),
    );
  }
}
