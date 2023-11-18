import 'package:flutter/cupertino.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataSource extends DataGridSource {
  ProductDataSource({required List<ProductsModel> products}) {
    _products = products
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.objectId),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'category', value: e.category?.categoryName),
              DataGridCell<String>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'discount', value: e.discount),
              DataGridCell<int>(columnName: 'salePrice', value: e.salePrice?.salePrice),
              DataGridCell<int>(columnName: 'PurchasePrice', value: e.purchasePrice?.purchasePrice),
              DataGridCell<String>(columnName: 'netValue', value: e.netValue),
              DataGridCell<String>(columnName: 'manufacturer', value: e.manufacturer),
            ]))
        .toList();
  }

  List<DataGridRow> _products = [];

  @override
  List<DataGridRow> get rows => _products;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' || dataGridCell.columnName == 'quantity')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}