class SalesItemsModel {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  Product? product;
  String? quantity;
  String? netPrice;

  SalesItemsModel(
      {this.className, this.objectId, this.createdAt, this.updatedAt, this.product, this.quantity, this.netPrice});

  SalesItemsModel.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    netPrice = json['netPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['className'] = className;
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['netPrice'] = netPrice;
    return data;
  }
}

class Product {
  String? className;
  String? objectId;

  Product({this.className, this.objectId});

  Product.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['className'] = className;
    data['objectId'] = objectId;
    return data;
  }
}
