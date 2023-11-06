import 'package:get/get.dart';
import 'package:pos_fyp/views/mobile_views/mob_dashbaord_screen.dart';

class DashbaordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => const DashboardScreen());
  }
}
