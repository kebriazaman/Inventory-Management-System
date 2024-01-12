import 'package:get/get.dart';

class SelectedProductModel {
  String? id;
  String? name;
  String? price;
  String? netPrice;
  int? inStockQty;
  RxInt? qty;

  SelectedProductModel(this.id, this.name, this.price, this.qty, this.netPrice, this.inStockQty);
}
