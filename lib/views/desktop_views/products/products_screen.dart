import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/components/info_card.dart';
import 'package:pos_fyp/utils/debouncer.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/product_data_source.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/utils/wave_painter.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/fading_circular_loading.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/filter_products_dropdown.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/input_search_field.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import './widgets/products_entry_button.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductsController productsController;
  late final NavigationController navigationController;
  late Debouncer debouncer;
  @override
  void initState() {
    super.initState();
    productsController = Get.put(ProductsController());
    navigationController = Get.find<NavigationController>();
    debouncer = Debouncer(millisecs: 800);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProductsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor4.withOpacity(0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              CustomPaint(
                painter: WavePainter(Utils.generatePoints(context)),
                child: Container(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Products',
                            style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            InputSearchField(
                              onTextChanged: (String value) {
                                debouncer.run(() {
                                  productsController.filterProductsByName(value.toString());
                                });
                              },
                            ),
                            10.width,
                            const ProductsEntryButton(),
                            10.width,
                            Obx(
                              () => productsController.isCategoryLoading.value
                                  ? const FadingCircularLoading()
                                  : const FilterProductsDropdown(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Obx(
                    () => Row(
                      children: [
                        InfoCard('Total Products', productsController.productsList.length,
                            ImageAssets.inventoryIconImage, AppColors.inventoryCardIconColor),
                        InfoCard('Available', productsController.availableItems.value, ImageAssets.SALES_ICON_IMAGE,
                            AppColors.inStockCardIconColor),
                        InfoCard('Out of Stock', productsController.unAvailableItems.value,
                            ImageAssets.SALES_ICON_IMAGE, AppColors.outStockCardIconColor),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Expanded(
                    child: Obx(
                      () => productsController.isLoading.value
                          ? Center(child: SpinKitWave(color: AppColors.blackColor.withOpacity(0.5), size: 30))
                          : SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: AppColors.greyColor.withOpacity(0.5)),
                              child: SfDataGrid(
                                selectionMode: SelectionMode.single,
                                navigationMode: GridNavigationMode.cell,
                                editingGestureType: EditingGestureType.tap,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility: GridLinesVisibility.both,
                                columnWidthMode: ColumnWidthMode.auto,
                                allowEditing: true,
                                headerRowHeight: 40,
                                columns: <GridColumn>[
                                  GridColumn(
                                    columnName: 'productId',
                                    label: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('ID'),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'productName',
                                    label: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Name'),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'productCategory',
                                    label: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Category'),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'quantity',
                                    label: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Quantity'),
                                    ),
                                  ),
                                  GridColumn(
                                    allowEditing: false,
                                    columnName: 'purchasePrice',
                                    label: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Purchase Price'),
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
                                    columnName: 'discount%',
                                    label: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Discount %'),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'discountValue',
                                    label: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Discount Value'),
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
                                    columnName: 'productStatus',
                                    label: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Status'),
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
                                source: ProductDataSource(context: context, productsController: productsController),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
