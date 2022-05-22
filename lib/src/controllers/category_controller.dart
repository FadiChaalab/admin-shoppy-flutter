import 'package:flutter/cupertino.dart';

class CategoryController extends ChangeNotifier {
  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;
  void changeCategory(int index) {
    _selectedCategory = index;
    notifyListeners();
  }
}
