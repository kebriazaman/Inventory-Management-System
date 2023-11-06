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
              child: Container(
                alignment: Alignment.center,
                width: Get.width,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: _buildSideSelectionBoxes(context),
                  ),
                ),
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

  List<Widget> _buildSideSelectionBoxes(BuildContext context) {
    List<Widget> _list = [];
    int length = _navigationController.sideSelectionBoxTitleList.length;
    String _title;
    IconData _icon;
    FocusNode _focusNode;
    for (int i = 0; i < length; i++) {
      _title = _navigationController.sideSelectionBoxTitleList[i];
      _icon = _navigationController.sideSelectionBoxIconList[i];
      _focusNode = _navigationController.sideSelectionBoxFocusNodeList[i];
      _list.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 44.0),
          child: Card(
            elevation: 5,
            child: InkWell(
              onTap: () {
                _navigationController.selectedIndex.value = i;
                FocusScope.of(context).requestFocus(_navigationController.sideSelectionBoxFocusNodeList[i]);
              },
              onFocusChange: (v) {
                if (v) {
                  _navigationController.selectedIndex.value = i;
                }
              },
              autofocus: i == 0 ? true : false,
              focusNode: _navigationController.sideSelectionBoxFocusNodeList[i],
              hoverColor: Colors.blue.shade100,
              focusColor: Colors.blue.shade100,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                constraints: BoxConstraints(
                  minHeight: 50,
                  maxHeight: 70,
                  minWidth: Get.width * .1,
                  maxWidth: Get.width * .1,
                ),
                child: Column(
                  children: [
                    Expanded(child: Icon(_icon)),
                    Text(_title),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return _list;
  }
}
