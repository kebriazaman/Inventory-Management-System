import 'package:get/get.dart';

class SelectedProductModel {
  String? id;
  String? name;
  String? price;
  String? netPrice;
  RxInt? qty;

  SelectedProductModel(this.id, this.name, this.price, this.qty, this.netPrice);
}
