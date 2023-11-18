import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/components/dashboard/info_card_widget.dart';
import 'package:pos_fyp/utils/product_data_source.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/utils/wave_painter.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/input_search_field.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/product_entry_form.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final productsController = Get.find<ProductsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsController.getCategoryList();
    productsController.getProducts();
  }

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
              children: [
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Products',
                          style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          InputSearchField(),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Add Product',
                                content: ProductsEntryForm(),
                              );
                            },
                            child: const Text(
                              'Add Product',
                              style: TextStyle(color: AppColors.buttonBackgroundColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: const Size(150, 50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InfoCardWidget(
                        'Total Products', '3000', ImageAssets.inventoryIconImage, AppColors.inventoryCardIconColor),
                    InfoCardWidget('In-Stock', '3000', ImageAssets.SALES_ICON_IMAGE, AppColors.inStockCardIconColor),
                    InfoCardWidget('Out-Stock', '3000', ImageAssets.SALES_ICON_IMAGE, AppColors.outStockCardIconColor),
                  ],
                ),
                Expanded(
                  child: Obx(
                    () => SfDataGrid(
                        columnWidthMode: ColumnWidthMode.fill,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'id',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('ID'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'name',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Name'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'category',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Category'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'qty',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Quantity'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'discount %',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Discount %'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'salePrice',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sale Price'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'purchasePrice',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Purchase Price'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'netValue',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Net Value'),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'manufacturer',
                            label: Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Manufacturer'),
                              ),
                            ),
                          ),
                        ],
                        source: ProductDataSource(products: productsController.productsList.value)),
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
