import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/views/mobile_views/dashbaord/dashboard_screen.dart';
import 'package:pos_fyp/views/mobile_views/products/products_screen.dart';
import 'package:pos_fyp/views/mobile_views/sales/sales_screen.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBarController extends GetxController {
  late final SidebarXController sidebarXController;
  final key = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    sidebarXController = SidebarXController(selectedIndex: 0, extended: false);
  }

  List<SidebarXItem> sidebarItems = [
    const SidebarXItem(icon: Icons.home, label: 'Dashboard'),
    const SidebarXItem(icon: Icons.inventory_outlined, label: 'Products'),
    const SidebarXItem(icon: Icons.settings, label: 'Sales'),
    const SidebarXItem(icon: Icons.dark_mode, label: 'Employees')
  ];

  List<Widget> screensList = [const DashboardScreen(), const ProductsScreen(), const SalesScreen()];

  void closeDrawerIfNeeded(BuildContext context) {
    key.currentState!.isDrawerOpen ? Navigator.of(context).pop() : null;
  }
}
