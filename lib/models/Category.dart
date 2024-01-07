class Category {
  Category({
    this.className,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
  });

  Category.fromJson(dynamic json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryName = json['categoryName'];
  }
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['className'] = className;
    map['objectId'] = objectId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['categoryName'] = categoryName;
    return map;
  }
}
