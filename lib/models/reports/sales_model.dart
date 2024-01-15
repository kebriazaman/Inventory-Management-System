class SalesModel {
  String? objectId;
  String? customCreatedAt;
  Customer? customer;
  String? paymentType;
  String? collectedAmount;
  String? changeAmount;
  String? subtotal;
  String? discount;
  String? tax;
  String? service;
  String? grandTotal;

  SalesModel({
    this.objectId,
    this.customCreatedAt,
    this.customer,
    this.paymentType,
    this.collectedAmount,
    this.changeAmount,
    this.subtotal,
    this.discount,
    this.tax,
    this.service,
    this.grandTotal,
  });

  SalesModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];

    customCreatedAt = json['customCreatedAt'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    paymentType = json['paymentType'];
    collectedAmount = json['collectedAmount'];
    changeAmount = json['changeAmount'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    tax = json['tax'];
    service = json['service'];
    grandTotal = json['grandTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['customCreatedAt'] = customCreatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['paymentType'] = paymentType;
    data['collectedAmount'] = collectedAmount;
    data['changeAmount'] = changeAmount;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['tax'] = tax;
    data['service'] = service;
    data['grandTotal'] = grandTotal;
    return data;
  }
}

class Customer {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? phoneNo;
  String? email;
  String? city;
  String? address;

  Customer(
      {this.className,
      this.objectId,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.phoneNo,
      this.email,
      this.city,
      this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    email = json['email'];
    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['className'] = className;
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['phoneNo'] = phoneNo;
    data['email'] = email;
    data['city'] = city;
    data['address'] = address;
    return data;
  }
}
