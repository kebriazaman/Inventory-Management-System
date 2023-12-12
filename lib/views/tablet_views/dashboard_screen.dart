import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/components/dashboard/info_card_widget.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/utils/wave_painter.dart';

class DashbaordScreen extends StatelessWidget {
  const DashbaordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: WavePainter(Utils.generatePoints(context)),
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoCardWidget('Total Sales', 1000, ImageAssets.SALES_ICON_IMAGE, AppColors.saleCardIconColor),
                    InfoCardWidget(
                        'Total Purchase', 1000, ImageAssets.PURCHASE_ICON_IMAGE, AppColors.purchaseCardIconColor),
                    InfoCardWidget(
                        'Total Customers', 1000, ImageAssets.CUSTOMER_ICON_IMAGE, AppColors.customerCardIconColor),
                  ],
                ),
                SizedBox(height: 40.0),
                Expanded(
                  child: Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        ListTile(
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
                        Divider(),
                        ListTile(
                          horizontalTitleGap: 1.0,
                          leading: Text(
                            'Stock Value',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
                          ),
                          trailing: Text(
                            'Rs. 1000',
                            style: TextStyle(color: Colors.lightGreen, fontSize: 15.0),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(index.toString()),
                                title: Text('Product Name'),
                                trailing: Text(
                                  'Rs. 20000',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
