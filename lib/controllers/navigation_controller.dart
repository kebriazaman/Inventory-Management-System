import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/views/desktop_views/customers/customer_screen.dart';
import 'package:pos_fyp/views/desktop_views/dashboard/dashboard_screen.dart';
import 'package:pos_fyp/views/desktop_views/products/products_screen.dart';
import 'package:pos_fyp/views/desktop_views/reports/reports_screen.dart';
import 'package:pos_fyp/views/desktop_views/sales/sales_screen.dart';
import 'package:pos_fyp/views/desktop_views/settings_screen.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  var hoverColor = Colors.blue.shade100.obs;

  FocusNode screenSelectionNode_1 = FocusNode();
  FocusNode screenSelectionNode_2 = FocusNode();
  FocusNode screenSelectionNode_3 = FocusNode();
  FocusNode screenSelectionNode_4 = FocusNode();
  FocusNode screenSelectionNode_5 = FocusNode();
  FocusNode screenSelectionNode_6 = FocusNode();

  List<String> get titlesList {
    return [
      'Dashboard',
      'Products',
      'Sale',
      'Customers',
      'Reports',
      'Settings',
    ];
  }

  List<IconData> get iconsList {
    return [
      Icons.dashboard,
      Icons.shopping_cart,
      Icons.point_of_sale,
      Icons.person,
      Icons.receipt,
      Icons.settings,
    ];
  }

  RxList<FocusNode> get sideSelectionBoxFocusNodeList {
    return [
      screenSelectionNode_1,
      screenSelectionNode_2,
      screenSelectionNode_3,
      screenSelectionNode_4,
      screenSelectionNode_5,
      screenSelectionNode_6,
    ].obs;
  }

  List<Widget> get screenList {
    return [
      DashboardScreen(),
      const ProductsScreen(),
      const SalesScreen(),
      const CustomersScreen(),
      const ReportsScreen(),
      const SettingsScreen(),
    ].obs;
  }
}
