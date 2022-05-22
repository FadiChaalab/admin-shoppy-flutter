import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/components/loading_widget.dart';
import 'package:admin_shop/src/components/no_data.dart';
import 'package:admin_shop/src/components/product_item.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/models/product.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ScrollController _newProductsController;
  late ScrollController _popularProductsController;
  late ScrollController _bestSellersController;
  late ScrollController _flashSalesController;
  late ScrollController _blackMarketController;
  late ScrollController _summerSalesController;
  late ScrollController _allProductsController;

  @override
  void initState() {
    _newProductsController = ScrollController();
    _popularProductsController = ScrollController();
    _bestSellersController = ScrollController();
    _flashSalesController = ScrollController();
    _blackMarketController = ScrollController();
    _summerSalesController = ScrollController();
    _allProductsController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _newProductsController.dispose();
    _popularProductsController.dispose();
    _bestSellersController.dispose();
    _flashSalesController.dispose();
    _blackMarketController.dispose();
    _summerSalesController.dispose();
    _allProductsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerModel>(context);
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
              const HeadlineTitle(title: 'Products'),
              DefaultButton(
                width: 134,
                radius: 8,
                height: 36,
                fontSize: 14,
                isUpper: false,
                text: 'Add product',
                press: () {
                  drawer.changeScreen(6);
                },
              )
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: const [
              SubTitle(title: 'Shoppy'),
              SizedBox(width: kDefaultPadding / 2),
              ArrowWidget(),
              SizedBox(width: kDefaultPadding / 2),
              SubTitle(title: 'Products'),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'All Products'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _allProductsController,
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = products[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Popular Products'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                List<Product> popularProducts = products.where((product) {
                  return product.popular;
                }).toList();
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _popularProductsController,
                    scrollDirection: Axis.horizontal,
                    itemCount: popularProducts.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = popularProducts[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'New Products'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                List<Product> newProducts = products.where((product) {
                  return product.newProduct;
                }).toList();
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _newProductsController,
                    scrollDirection: Axis.horizontal,
                    itemCount: newProducts.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = newProducts[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Flash Sales'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                List<Product> flashSales = products.where((product) {
                  return product.flashSales;
                }).toList();
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _flashSalesController,
                    scrollDirection: Axis.horizontal,
                    itemCount: flashSales.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = flashSales[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Best Sellers'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                List<Product> bestSellers = products.where((product) {
                  return product.bestSeller;
                }).toList();
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _bestSellersController,
                    scrollDirection: Axis.horizontal,
                    itemCount: bestSellers.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = bestSellers[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Summer Sales'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                List<Product> summerSales = products.where((product) {
                  return product.summerSales;
                }).toList();
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _summerSalesController,
                    scrollDirection: Axis.horizontal,
                    itemCount: summerSales.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = summerSales[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Black Friday'),
          const SizedBox(height: kDefaultPadding),
          Consumer<List<Product>?>(builder: (context, products, _) {
            if (products != null) {
              if (products.isNotEmpty) {
                List<Product> blackFriday = products.where((product) {
                  return product.blackMarket;
                }).toList();
                return SizedBox(
                  height: 304,
                  child: ListView.builder(
                    controller: _blackMarketController,
                    scrollDirection: Axis.horizontal,
                    itemCount: blackFriday.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Product product = blackFriday[index];
                      return ProductItem(
                        title: product.title,
                        image: product.images.first,
                        price: product.price.toString(),
                        remise: product.remise.toString(),
                        onTap: () {
                          drawer.setProduct(product);
                          drawer.changeScreen(7);
                        },
                      );
                    },
                  ),
                );
              } else {
                return const NoDataWidget();
              }
            } else if (products == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
        ],
      ),
    );
  }
}
