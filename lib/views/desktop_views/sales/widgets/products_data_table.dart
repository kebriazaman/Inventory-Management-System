import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';

class ProductsDataTable extends StatelessWidget {
  const ProductsDataTable({super.key});
  @override
  Widget build(BuildContext context) {
    final SalesController salesController = Get.find<SalesController>();
    return Expanded(
      child: Obx(
        () => DataTable2(
          datarowCheckboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(AppColors.blackColor),
            fillColor: MaterialStateProperty.all(AppColors.whiteColor),
            shape: const CircleBorder(),
            side: const BorderSide(color: AppColors.appButtonColor),
          ),
          headingCheckboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(AppColors.blackColor),
            fillColor: MaterialStateProperty.all(AppColors.whiteColor),
            shape: const CircleBorder(),
            side: const BorderSide(color: AppColors.appButtonColor),
          ),
          dataRowColor: MaterialStateProperty.all(AppColors.whiteColor),
          dataTextStyle: Theme.of(context).textTheme.bodySmall,
          headingRowDecoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1)),
          headingRowHeight: Get.height * 0.05,
          columnSpacing: 20,
          columns: salesController.dataTableColumns,
          horizontalMargin: 20.0,
          checkboxHorizontalMargin: 10.0,
          rows: salesController.filteredProducts.map((element) {
            bool selected =
                salesController.selectedProducts.any((selectedElement) => selectedElement.id == element.objectId);

            return DataRow2(
                selected: selected,
                onSelectChanged: element.status == 'out-of-stock'
                    ? null
                    : (isSelected) {
                        if (isSelected != null) {
                          if (isSelected) {
                            salesController.addSelectedElement(element);
                          } else {
                            salesController.removeSelectedElement(element);
                          }
                        }
                      },
                cells: [
                  DataCell(Text(element.objectId)),
                  DataCell(Text(element.name)),
                  DataCell(Text(element.category.categoryName)),
                  DataCell(Text(element.quantity)),
                  DataCell(Text(element.netValue)),
                  DataCell(Text(element.status)),
                  DataCell(Text(element.manufacturer)),
                ]);
          }).toList(),
        ),
      ),
    );
  }
}
