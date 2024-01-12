import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';
import 'package:pos_fyp/views/desktop_views/main/widgets/side_nav_bar.dart';

class MainScreen extends StatelessWidget {
  final _navigationController = Get.find<NavigationController>();
  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------- Drawer Section ----------------------
            const Expanded(
              flex: 1,
              child: SideNavBar(),
            ),
            const VerticalDivider(),
            // -------------------- page section -------------------------
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => _navigationController.screenList[_navigationController.selectedIndex.value],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
