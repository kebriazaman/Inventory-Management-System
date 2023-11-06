import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ProductsController());
  }
}
