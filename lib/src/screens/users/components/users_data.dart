import 'package:admin_shop/src/controllers/theme_controller.dart';
import 'package:admin_shop/src/models/user.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsersDataSource extends DataGridSource {
  UsersDataSource({required List<UserModel?> usersData}) {
    _usersData = usersData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'id',
                value: e!.uid,
              ),
              DataGridCell<String>(
                columnName: 'first',
                value: e.firstName,
              ),
              DataGridCell<String>(
                columnName: 'last',
                value: e.lastName,
              ),
              DataGridCell<String>(
                columnName: 'email',
                value: e.email,
              ),
              DataGridCell<int>(
                columnName: 'phone',
                value: e.phone,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _usersData = [];

  @override
  List<DataGridRow> get rows => _usersData;

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
