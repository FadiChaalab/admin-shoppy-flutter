import 'package:admin_shop/src/controllers/theme_controller.dart';
import 'package:admin_shop/src/models/order.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrdersDataSource extends DataGridSource {
  OrdersDataSource({required List<Order?> ordersData}) {
    _ordersData = ordersData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'id',
                value: e!.id,
              ),
              DataGridCell<String>(
                columnName: 'username',
                value: e.userName,
              ),
              DataGridCell<String>(
                columnName: 'email',
                value: e.userEmail,
              ),
              DataGridCell<String>(
                columnName: 'phone',
                value: e.userPhone,
              ),
              DataGridCell<String>(
                columnName: 'address',
                value: e.userAddress,
              ),
              DataGridCell<String>(
                columnName: 'ordered',
                value: DateFormat.yMMMMd().format(DateTime.parse(e.dateTime)),
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _ordersData = [];

  @override
  List<DataGridRow> get rows => _ordersData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ThemeController>(builder: (context, theme, _) {
          return Text(
            e.value.toString(),
            style: TextStyle(
              color: theme.darkMode ? kTextColor : kTextDarkColor,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          );
        }),
      );
    }).toList());
  }
}
