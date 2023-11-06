import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  List<String> get drawerMenuItemTitleList {
    return [
      'Dashboard',
      'Products',
      'Sale',
      'Purchase',
      'Customers',
      'Reports',
      'Settings',
    ];
  }

  List<Icon> get drawerMenuItemIconList {
    return [
      Icon(Icons.dashboard),
      Icon(Icons.production_quantity_limits),
      Icon(Icons.point_of_sale),
      Icon(Icons.shopping_cart),
      Icon(Icons.person),
      Icon(Icons.receipt),
      Icon(Icons.settings),
    ];
  }
}
