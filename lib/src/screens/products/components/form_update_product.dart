import 'package:admin_shop/src/components/custom_text_form_field.dart';
import 'package:admin_shop/src/components/default_button.dart';
import 'package:admin_shop/src/controllers/drawer_controller.dart';
import 'package:admin_shop/src/db/products_repo.dart';
import 'package:admin_shop/src/models/product.dart';
import 'package:admin_shop/src/services/locator.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProductForm extends StatefulWidget {
  final Product product;
  const UpdateProductForm({Key? key, required this.product}) : super(key: key);

  @override
  _UpdateProductFormState createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _productsRepo = ProductRepository();
  final drawer = locator.get<DrawerModel>();

  String? title;
  String? titleError;
  String? description;
  String? descriptionError;
  String? price;
  String? priceError;
  String? category;
  String? categoryError;
  String? quantity;
  String? quantityError;
  String? brand;
  String? brandError;
  String? remise;
  String? remiseError;

  updateProduct() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _productsRepo
          .updateProduct(widget.product.copyWith(
            title: title,
            description: description,
            price: double.parse(price!),
            category: category,
            quantity: int.parse(quantity!),
            brand: brand,
            remise: double.parse(remise!),
          ))
          .then((value) => drawer.changeScreen(4));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            AppLocalizations.of(context)!.offline,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FadeInDown(
                  preferences: const AnimationPreferences(
                    offset: Duration(milliseconds: 400),
                  ),
                  child: CustomTextFormField(
                    initialValue: widget.product.title,
                    hintText: 'Enter title',
                    onSaved: (newValue) => title = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          titleError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          titleError = 'Title is required';
                        });
                      }
                      return titleError;
                    },
                    keyboardType: TextInputType.text,
                    prefixIcon: "assets/icons/Document.svg",
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 3,
                child: FadeInDown(
                  preferences: const AnimationPreferences(
                    offset: Duration(milliseconds: 600),
                  ),
                  child: CustomTextFormField(
                    initialValue: widget.product.brand,
                    hintText: 'Enter brand',
                    onSaved: (newValue) => brand = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          brandError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          brandError = 'brand is required';
                        });
                      }
                      return brandError;
                    },
                    keyboardType: TextInputType.text,
                    prefixIcon: "assets/icons/Edit.svg",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FadeInDown(
                  preferences: const AnimationPreferences(
                    offset: Duration(milliseconds: 800),
                  ),
                  child: CustomTextFormField(
                    initialValue: widget.product.price.toString(),
                    hintText: 'Enter price',
                    onSaved: (newValue) => price = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          priceError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          priceError = 'Price is required';
                        });
                      }
                      return priceError;
                    },
                    keyboardType: TextInputType.number,
                    prefixIcon: "assets/icons/Wallet.svg",
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 3,
                child: FadeInDown(
                  preferences: const AnimationPreferences(
                    offset: Duration(milliseconds: 1000),
                  ),
                  child: CustomTextFormField(
                    initialValue: widget.product.quantity.toString(),
                    hintText: 'Enter quantity',
                    onSaved: (newValue) => quantity = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          quantityError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          quantityError = 'Quantity is required';
                        });
                      }
                      return quantityError;
                    },
                    keyboardType: TextInputType.number,
                    prefixIcon: "assets/icons/Edit.svg",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FadeInDown(
                  preferences: const AnimationPreferences(
                    offset: Duration(milliseconds: 1200),
                  ),
                  child: CustomTextFormField(
                    initialValue: widget.product.category,
                    hintText: 'Enter category',
                    onSaved: (newValue) => category = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          categoryError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          categoryError = 'category is required';
                        });
                      }
                      return categoryError;
                    },
                    keyboardType: TextInputType.text,
                    prefixIcon: "assets/icons/Edit.svg",
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 3,
                child: FadeInDown(
                  preferences: const AnimationPreferences(
                    offset: Duration(milliseconds: 1400),
                  ),
                  child: CustomTextFormField(
                    initialValue: widget.product.remise.toString(),
                    hintText: 'Enter remise',
                    onSaved: (newValue) => remise = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          remiseError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          remiseError = 'remise is required';
                        });
                      }
                      return remiseError;
                    },
                    keyboardType: TextInputType.text,
                    prefixIcon: "assets/icons/Edit.svg",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1600),
            ),
            child: CustomTextFormField(
              initialValue: widget.product.description,
              hintText: 'Enter description',
              maxLines: 3,
              onSaved: (newValue) => description = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    descriptionError = null;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    descriptionError = 'description is required';
                  });
                }
                return descriptionError;
              },
              keyboardType: TextInputType.text,
              prefixIcon: "assets/icons/Edit.svg",
            ),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1800),
            ),
            child: DefaultButton(
              text: 'Update',
              width: 98,
              height: 40,
              radius: 8,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  updateProduct();
                }
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
