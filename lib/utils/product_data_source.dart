import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataSource extends DataGridSource {
  BuildContext context;
  ProductsController productsController;
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();
  List<DataGridRow> dataGridRows = [];
  List<ProductsModel> products = [];
  ProductDataSource({required this.context, required this.products, required this.productsController}) {
    dataGridRows = products
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.objectId),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'category', value: e.category?.categoryName),
              DataGridCell<String>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'discount', value: e.discount),
              DataGridCell<int>(columnName: 'salePrice', value: e.salePrice?.salePrice),
              DataGridCell<int>(columnName: 'purchasePrice', value: e.purchasePrice?.purchasePrice),
              DataGridCell<String>(columnName: 'netValue', value: e.netValue),
              DataGridCell<String>(columnName: 'manufacturer', value: e.manufacturer),
              DataGridCell(columnName: 'delete', value: null),
            ]))
        .toList();
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
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  productsController.deleteProduct(row.getCells()[0].value);
                },
              ),
            )
          : Container(
              alignment: (dataGridCell.columnName == 'quantity' ||
                      dataGridCell.columnName == 'discount' ||
                      dataGridCell.columnName == 'purchasePrice' ||
                      dataGridCell.columnName == 'salePrice' ||
                      dataGridCell.columnName == 'netValue')
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(dataGridCell.value.toString(), style: Theme.of(context).textTheme.bodySmall),
            );
    }).toList());
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
    // await Future<void>.delayed(const Duration(seconds: 2));
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);
    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'name') {
      // dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
      //     DataGridCell<String>(columnName: 'name', value: newCellValue);
      // products[dataRowIndex].name = newCellValue;
      var objectId = dataGridRows[dataRowIndex].getCells()[0];
      productsController.updateProductName(objectId.value, newCellValue);
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
    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    return TextFormField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      controller: editingController..text = displayText,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
      ),
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
    if (column.columnName == 'id' || column.columnName == 'delete') {
      return false;
    } else {
      return true;
    }
  }
}
