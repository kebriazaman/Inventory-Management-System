import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/tablet/drawer_navigation_controller.dart';

class MySideDrawer extends StatelessWidget {
  const MySideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerNavigationController = Get.put(DrawerNavigationController());
    return Drawer(
      child: Column(
        children: [
          const Flexible(
            child: DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Icon(Icons.person),
                    Text('Welcome'),
                    Text('kebriazaman', style: TextStyle(fontSize: 26, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: drawerNavigationController.drawerMenuItemIconList.length,
              itemBuilder: (context, index) {
                var sideIcon = drawerNavigationController.drawerMenuItemIconList[index];
                var titleText = drawerNavigationController.drawerMenuItemTitleList[index];
                return Obx(
                  () => ListTile(
                    selected: index == drawerNavigationController.selectedIndex.value,
                    leading: sideIcon,
                    title: Text(titleText, style: const TextStyle(overflow: TextOverflow.ellipsis)),
                    onTap: () {
                      drawerNavigationController.selectedIndex.value = index;
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
