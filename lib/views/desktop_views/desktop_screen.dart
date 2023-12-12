import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';

class DesktopScreen extends StatelessWidget {
  final _navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------- Drawer Section ----------------------
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _navigationController.iconsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          _navigationController.selectedIndex.value = index;
                          FocusScope.of(context)
                              .requestFocus(_navigationController.sideSelectionBoxFocusNodeList[index]);
                        },
                        onFocusChange: (v) {
                          if (v) {
                            _navigationController.selectedIndex.value = index;
                          }
                        },
                        autofocus: index == 0 ? true : false,
                        focusNode: _navigationController.sideSelectionBoxFocusNodeList[index],
                        hoverColor: Colors.blue.shade100,
                        focusColor: Colors.blue.shade100,
                        child: SizedBox(
                          width: Get.width * 0.1,
                          height: Get.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(_navigationController.iconsList[index]),
                                Expanded(
                                  child: Text(
                                    _navigationController.titlesList[index],
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 32.0),
              child: VerticalDivider(),
            ),
            // -------------------- page section -------------------------
            Expanded(
              flex: 4,
              child: Obx(
                () => _navigationController.screenList[_navigationController.selectedIndex.value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
