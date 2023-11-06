import 'package:get/get.dart';
import 'package:pos_fyp/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignupController());
  }
}
