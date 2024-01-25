import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataSource extends DataGridSource {
  BuildContext context;
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();
  ProductsController productsController;
  List<DataGridRow> dataGridRows = [];

  ProductDataSource({required this.context, required this.productsController}) {
    dataGridRows = productsController.filteredProducts.reversed
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'productId', value: e.objectId),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'category', value: e.category?.categoryName),
              DataGridCell<String>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'purchasePrice', value: e.purchasePrice),
              DataGridCell<String>(columnName: 'salePrice', value: e.salePrice),
              DataGridCell<String>(columnName: 'discount%', value: e.discountPercentage),
              DataGridCell<String>(columnName: 'discountValue', value: e.discountValue),
              DataGridCell<String>(columnName: 'netValue', value: e.netValue),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'manufacturer', value: e.manufacturer),
              const DataGridCell(columnName: 'delete', value: null),
            ]))
        .toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((dataGridCell) {
        return dataGridCell.columnName == 'delete'
            ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  hoverColor: AppColors.transparentColor,
                  icon: const Icon(Icons.delete, color: AppColors.redColor),
                  onPressed: () {
                    productsController.deleteProduct(row.getCells()[0].value);
                    productsController.watchItemsStatus();
                  },
                ),
              )
            : Container(
                alignment: (dataGridCell.columnName == 'quantity' ||
                        dataGridCell.columnName == 'discount%' ||
                        dataGridCell.columnName == 'discountValue' ||
                        dataGridCell.columnName == 'purchasePrice' ||
                        dataGridCell.columnName == 'salePrice' ||
                        dataGridCell.columnName == 'netValue')
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  dataGridCell.value.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: dataGridCell.value == 'out-of-stock' ? AppColors.redColor : AppColors.blackColor,
                      ),
                ),
              );
      }).toList(),
    );
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);
    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'productName') {
      var objectId = dataGridRows[dataRowIndex].getCells()[0];
      productsController.updateProductName(objectId.value, newCellValue);
    }
    if (column.columnName == 'discount%') {
      var objectId = dataGridRows[dataRowIndex].getCells()[0];
      productsController.updateProductDiscount(objectId.value, newCellValue);
    }
    if (column.columnName == 'salePrice') {
      var objectId = dataGridRows[dataRowIndex].getCells()[0];
      productsController.updateSalePrice(objectId.value, newCellValue);
    }
    if (column.columnName == 'quantity') {
      var objectId = dataGridRows[dataRowIndex].getCells()[0];
      productsController.updateProductQuantity(objectId.value, newCellValue);
    }
  }

  @override
  Widget? buildEditWidget(
      DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value ??
        '';
    newCellValue = null;
    return TextFormField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      controller: editingController..text = displayText,
      cursorHeight: 20.0,
      decoration: kTextInputFieldDecoration.copyWith(
          hintText: '', contentPadding: const EdgeInsets.symmetric(horizontal: 8.0)),
      onChanged: (value) {
        if (value.isNotEmpty) {
          newCellValue = value.toString();
        } else {
          newCellValue = null;
        }
      },
      onFieldSubmitted: (value) {
        submitCell();
      },
    );
  }

  @override
  bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    if (column.columnName == 'id' ||
        column.columnName == 'productCategory' ||
        column.columnName == 'delete' ||
        column.columnName == 'discountValue' ||
        column.columnName == 'productStatus' ||
        column.columnName == 'netValue') {
      return false;
    } else {
      return true;
    }
  }
}
