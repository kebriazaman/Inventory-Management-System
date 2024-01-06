class CustomersModel {
  String? objectId;
  String? address;
  String? city;
  String? email;
  String? phoneNo;
  String? name;

  CustomersModel({this.objectId, this.address, this.city, this.email, this.phoneNo, this.name});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    address = json['address'];
    city = json['city'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['name'] = this.name;
    return data;
  }
}
