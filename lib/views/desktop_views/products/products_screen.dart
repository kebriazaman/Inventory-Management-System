import 'dart:async';

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

  Timer? typingTimer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsController.getCategoryList();
    productsController.getProducts();
    productsController.runLiveQuery();
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
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Products',
                          style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          InputSearchField(
                            onTextChanged: (String value) {
                              if (typingTimer != null && typingTimer!.isActive) {
                                typingTimer!.cancel();
                              }
                              typingTimer = Timer(const Duration(seconds: 1), () {
                                // Perform your action here when typing stops (e.g., validation, API call, etc.)
                                print('User typed: ${value}');
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Add Product',
                                content: const ProductsEntryForm(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              minimumSize: const Size(150, 48),
                            ),
                            child: const Text(
                              'Add Product',
                              style: TextStyle(color: AppColors.buttonBackgroundColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                Row(
                  children: [
                    Obx(
                      () => InfoCardWidget('Total Products', productsController.productsList.value.length,
                          ImageAssets.inventoryIconImage, AppColors.inventoryCardIconColor),
                    ),
                    const InfoCardWidget(
                        'In-Stock', 3000, ImageAssets.SALES_ICON_IMAGE, AppColors.inStockCardIconColor),
                    const InfoCardWidget(
                        'Out-Stock', 3000, ImageAssets.SALES_ICON_IMAGE, AppColors.outStockCardIconColor),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                Expanded(
                  child: Obx(
                    () => productsController.isProductLoading.value == true
                        ? const Center(child: CircularProgressIndicator())
                        : SfDataGrid(
                            selectionMode: SelectionMode.single,
                            columnWidthMode: ColumnWidthMode.fill,
                            navigationMode: GridNavigationMode.cell,
                            editingGestureType: EditingGestureType.tap,
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                            allowEditing: true,
                            columns: <GridColumn>[
                              GridColumn(
                                columnName: 'id',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('ID'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'name',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Name'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'category',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Category'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'qty',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Quantity'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'discount %',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Discount %'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'salePrice',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Sale Price'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'purchasePrice',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Purchase Price'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'netValue',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Net Value'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'manufacturer',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Manufacturer'),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'delete',
                                label: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Action'),
                                  ),
                                ),
                              ),
                            ],
                            source: ProductDataSource(
                                context: context,
                                products: productsController.productsList,
                                productsController: productsController)),
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
