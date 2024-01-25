class SalesItemsModel {
  String? objectId;

  Product? product;
  String? quantity;
  String? netPrice;

  SalesItemsModel({this.objectId, this.product, this.quantity, this.netPrice});

  SalesItemsModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];

    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    netPrice = json['netPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;

    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['netPrice'] = netPrice;
    return data;
  }
}

class Product {
  String? objectId;

  String? name;
  String? quantity;
  String? discountPercentage;
  String? discountValue;
  String? salePrice;
  String? purchasePrice;
  String? netValue;
  String? manufacturer;
  String? status;

  Product(
      {this.objectId,
      this.name,
      this.quantity,
      this.discountPercentage,
      this.discountValue,
      this.salePrice,
      this.purchasePrice,
      this.netValue,
      this.manufacturer,
      this.status});

  Product.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];

    name = json['name'];
    quantity = json['quantity'];
    discountPercentage = json['discountPercentage'];
    discountValue = json['discountValue'];
    salePrice = json['salePrice'];
    purchasePrice = json['purchasePrice'];
    netValue = json['netValue'];
    manufacturer = json['manufacturer'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;

    data['name'] = name;
    data['quantity'] = quantity;
    data['discountPercentage'] = discountPercentage;
    data['discountValue'] = discountValue;
    data['salePrice'] = salePrice;
    data['purchasePrice'] = purchasePrice;
    data['netValue'] = netValue;
    data['manufacturer'] = manufacturer;
    data['status'] = status;
    return data;
  }
}
