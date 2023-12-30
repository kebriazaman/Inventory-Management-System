import 'package:get/get.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';

class NavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
