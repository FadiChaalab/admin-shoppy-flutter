import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/components/loading_widget.dart';
import 'package:admin_shop/src/components/no_data.dart';
import 'package:admin_shop/src/controllers/orders_controller.dart';
import 'package:admin_shop/src/models/order.dart';
import 'package:admin_shop/src/models/user.dart';
import 'package:admin_shop/src/screens/dashboard/components/static_info.dart';
import 'package:admin_shop/src/screens/users/components/users_data.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<charts.Series<Order, String>> _seriesBarData;
  late UsersDataSource _dataSource;
  _generateData(mydata) {
    _seriesBarData = [];
    _seriesBarData.add(
      charts.Series(
        domainFn: (Order orders, _) => orders.total.toString(),
        measureFn: (Order orders, _) => DateTime.parse(orders.dateTime).day,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.lighter,
        id: 'Orders',
        data: mydata,
        labelAccessorFn: (Order row, _) => "${row.total}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const SizedBox(height: kDefaultPadding),
          const HeadlineTitle(title: 'Dashboard'),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: const [
              SubTitle(title: 'Shoppy'),
              SizedBox(width: kDefaultPadding / 2),
              ArrowWidget(),
              SizedBox(width: kDefaultPadding / 2),
              SubTitle(title: 'Dashboard'),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Statistics'),
          const SizedBox(height: kDefaultPadding),
          Consumer<OrdersController>(builder: (context, orders, _) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: StaticInfoCard(
                    title: 'Products',
                    average: orders.averageOrderQuantity.toString() + '%',
                    color: kDarkPrimaryColor,
                    icon: 'assets/icons/Folder.svg',
                    percent: orders.averageOrderQuantity,
                    subtitle: 'Number of products ' +
                        orders.totalOrderQuantity.toString(),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 3,
                  child: StaticInfoCard(
                    title: 'Revenue',
                    average: orders.averageRevenue.toString() + '%',
                    color: kDarkSuccessColor,
                    icon: 'assets/icons/Wallet.svg',
                    percent: orders.averageRevenue,
                    subtitle: '\$' + orders.totalOrderPrice.toString(),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: kDefaultPadding),
          Consumer<OrdersController>(builder: (context, orders, _) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: StaticInfoCard(
                    title: 'Orders',
                    average: orders.averageOrderQuantity.toString() + '%',
                    color: kMonoColor,
                    icon: 'assets/icons/Shop.svg',
                    percent: orders.averageOrderQuantity,
                    subtitle: 'Total orders ' + orders.totalOrders.toString(),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 3,
                  child: StaticInfoCard(
                    title: 'Average Revenue',
                    average: orders.averageRevenue.toString() + '%',
                    color: kInfoColor,
                    icon: 'assets/icons/Wallet.svg',
                    percent: orders.averageRevenue,
                    subtitle: 'Average ' + orders.averageOrderPrice.toString(),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Charts'),
          const SizedBox(height: kDefaultPadding),
          Consumer<OrdersController>(builder: (context, orders, _) {
            if (orders.orders.isEmpty) {
              return const NoDataWidget();
            } else {
              _generateData(orders.orders);
              return SizedBox(
                height: 300,
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: kDefaultAnimationDuration,
                  behaviors: [
                    charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.gray.shadeDefault,
                      ),
                    )
                  ],
                ),
              );
            }
          }),
          const SizedBox(height: kDefaultPadding * 2),
          const Headline2Title(title: 'Users'),
          const SizedBox(height: kDefaultPadding),
          SizedBox(
            height: 420,
            child: Consumer<List<UserModel?>?>(
              builder: (context, controller, _) {
                if (controller != null) {
                  if (controller.isNotEmpty) {
                    _dataSource = UsersDataSource(usersData: controller);
                    return SfDataGrid(
                      showCheckboxColumn: true,
                      showSortNumbers: true,
                      selectionMode: SelectionMode.multiple,
                      source: _dataSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      columns: <GridColumn>[
                        GridColumn(
                          columnName: 'id',
                          label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: Text(
                              'ID',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'first',
                          label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'last',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text(
                              'Last Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'email',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text(
                              'Email',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'phone',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const NoDataWidget();
                  }
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
