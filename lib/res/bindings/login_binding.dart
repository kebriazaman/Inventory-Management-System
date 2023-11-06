import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController());
  }
}
