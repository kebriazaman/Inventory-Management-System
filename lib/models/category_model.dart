class CategoryModel {
  String? id;
  String? name;
  CategoryModel({this.id, this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['objectId'], name: json['categoryName']);
  }

  bool filterByName(String filter) {
    return name.toString().contains(filter);
  }
}
