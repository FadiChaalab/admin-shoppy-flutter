import 'package:admin_shop/src/db/orders.dart';
import 'package:admin_shop/src/models/order.dart';
import 'package:flutter/cupertino.dart';

class OrdersController extends ChangeNotifier {
  List<Order> _orders = [];
  final _ordersRepository = Orders();
  OrdersController() {
    _ordersRepository.getOrders().listen((orders) {
      _orders = orders;
      notifyListeners();
    });
  }

  List<Order> get orders => _orders;

  get totalOrders => _orders.length;

  get averageOrderPrice => _orders.isNotEmpty
      ? _orders
              .map((order) => order.total)
              .reduce((value, element) => value + element) /
          _orders.length
      : 0;

  get totalOrderPrice => _orders.isNotEmpty
      ? _orders
          .map((order) => order.total)
          .reduce((value, element) => value + element)
      : 0;

  get totalOrderQuantity => _orders.isNotEmpty
      ? _orders
          .map((order) => order.quantity)
          .reduce((value, element) => value + element)
      : 0;

  get revenue => _orders.isNotEmpty
      ? _orders
          .map((order) => order.total)
          .reduce((value, element) => value + element)
      : 0;

  get averageRevenue => _orders.isNotEmpty
      ? _orders
              .map((order) => order.total)
              .reduce((value, element) => value + element) /
          _orders.length
      : 0;

  get averageOrderQuantity => _orders.isNotEmpty
      ? _orders
              .map((order) => order.quantity)
              .reduce((value, element) => value + element) /
          _orders.length
      : 0;
}
