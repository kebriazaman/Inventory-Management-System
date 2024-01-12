import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/components/dashboard/info_list_card_widget.dart';
import 'package:pos_fyp/res/components/info_card.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/utils/wave_painter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatelessWidget {
  List<String> productsList = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
    'Product 6',
  ];

  List<String> customersList = [
    'Customer 1',
    'Customer 2',
    'Customer 3',
    'Customer 4',
    'Customer 5',
    'Customer 6',
    'Customer 7',
    'Customer 8',
    'Customer 9',
  ];

  List<String> purchaseProductsList = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
    'Product 6',
  ];

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 20),
    _SalesData('July', 10),
    _SalesData('Aug', 50),
    _SalesData('Sep', 4),
    _SalesData('Oct', 60),
    _SalesData('Nov', 36),
    _SalesData('Dec', 21),
  ];

  final _navigationController = Get.find<NavigationController>();

  DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => ParseUser.currentUser().then(
            (currentUser) async {
              if (currentUser != null) {
                await currentUser.logout();
                Get.offNamed(RouteName.loginScreen);
              }
              ;
            },
          ),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: WavePainter(Utils.generatePoints(context)),
              child: Container(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(48, 20, 0, 50),
                          child: Text('Dashboard',
                              style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    AspectRatio(
                      aspectRatio: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InfoCard('Total Sales', 20000, ImageAssets.SALES_ICON_IMAGE,
                                        AppColors.saleCardIconColor),
                                    InfoCard('Total Purchase', 49000, ImageAssets.PURCHASE_ICON_IMAGE,
                                        AppColors.purchaseCardIconColor),
                                    InfoCard('Total Customers', 30000, ImageAssets.CUSTOMER_ICON_IMAGE,
                                        AppColors.customerCardIconColor),
                                  ],
                                ),
                                Expanded(
                                  child: Card(
                                    child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(
                                        majorGridLines: const MajorGridLines(width: 0),
                                        axisLine: const AxisLine(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        axisLine: const AxisLine(width: 0),
                                        interval: 10,
                                      ),
                                      title: ChartTitle(
                                          text: 'Yearly Sales',
                                          textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                      tooltipBehavior: TooltipBehavior(enable: true),
                                      series: <ChartSeries<_SalesData, String>>[
                                        LineSeries<_SalesData, String>(
                                          dataSource: data,
                                          xValueMapper: (_SalesData sales, _) => sales.year,
                                          yValueMapper: (_SalesData sales, _) => sales.sales,
                                          name: 'Sales',
                                          // Enable data label
                                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 1,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const ListTile(
                                            horizontalTitleGap: 1.0,
                                            leading: Icon(Icons.inventory_outlined),
                                            title: Text(
                                              'Stock Inventory',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          const ListTile(
                                            horizontalTitleGap: 1.0,
                                            leading: Text(
                                              'Stock Value',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            trailing: Text(
                                              'Rs. 1000',
                                              style: TextStyle(color: Colors.lightGreen),
                                            ),
                                          ),
                                          const Divider(),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: ListTile(
                                              leading: Text(
                                                'No',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              title: Text(
                                                'Product',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              trailing: Text(
                                                'Price',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 10,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    leading: Text(
                                                      '${index + 1}',
                                                      style: const TextStyle(fontSize: 13),
                                                    ),
                                                    title: Text(
                                                      'Product ${index + 1}',
                                                      style: const TextStyle(fontSize: 13),
                                                    ),
                                                    trailing: const Text(
                                                      'Rs. 20000',
                                                      style: TextStyle(color: Colors.redAccent, fontSize: 13),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 2,
                      child: Row(
                        children: [
                          InfoListCardWidget(
                              title: 'Top monthly Customers', dataList: customersList, icon: Icons.person),
                          InfoListCardWidget(
                              title: 'Top Selling Products', dataList: productsList, icon: Icons.sell_outlined),
                          InfoListCardWidget(
                              title: 'Top Purchase Products',
                              dataList: purchaseProductsList,
                              icon: Icons.production_quantity_limits),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  final String year;
  final double sales;
  _SalesData(this.year, this.sales);
}
