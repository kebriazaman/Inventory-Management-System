import 'package:pos_fyp/data/parse_services/parse_network_services/parse_network_servies.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/products/products_model.dart';

class SalesRepository {
  final ParseNetworkServices services = ParseNetworkServices();
  Future<List<ProductsModel>> getProducts() async {
    dynamic response = await services.getData('Products', ['category'], null, null);
    var products = (response as List).map((e) => ProductsModel.fromJson(e)).toList();
    return products;
  }

  Future<dynamic> saveProduct() async {
    dynamic response = await services.addData('Sales', ['kebria']);
    return response;
  }

  Future<List<CategoryModel>> getCategories() async {
    dynamic response = await services.getData('Category', null, null, null);
    var categories = (response as List).map((e) => CategoryModel.fromJson(e)).toList();
    return categories;
  }

  Future<List<ProductsModel>> getProductsByCategory(String id) async {
    dynamic response = await services.getData('Products', ['category'], 'category', [id]);
    if (response != null) {
      var products = (response as List).map((e) => ProductsModel.fromJson(e)).toList();
      return products;
    } else {
      return [];
    }
  }

  Future<List<ProductsModel>> getFilteredProducts(String value) async {
    dynamic response = await services.getData('Products', null, 'name', [value]);
    if (response == null) return [];
    var products = (response as List).map((e) => ProductsModel.fromJson(e)).toList();
    return products;
  }
}
