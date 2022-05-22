import 'package:admin_shop/src/models/product.dart';
import 'package:flutter/cupertino.dart';

class DrawerModel extends ChangeNotifier {
  int _currentScreen = 0;
  int get currentScreen => _currentScreen;
  late Product _product;
  Product get product => _product;
  void changeScreen(int index) {
    _currentScreen = index;
    notifyListeners();
  }

  void setProduct(Product product) {
    _product = product;
    notifyListeners();
  }
}
