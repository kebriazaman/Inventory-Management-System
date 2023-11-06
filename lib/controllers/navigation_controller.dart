import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/views/desktop_views/customer_screen.dart';
import 'package:pos_fyp/views/desktop_views/dashboard/dashboard_screen.dart';
import 'package:pos_fyp/views/desktop_views/products/products_screen.dart';
import 'package:pos_fyp/views/desktop_views/purchase_screen.dart';
import 'package:pos_fyp/views/desktop_views/reports_screen.dart';
import 'package:pos_fyp/views/desktop_views/sales_screen.dart';
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
  FocusNode screenSelectionNode_7 = FocusNode();

  List<String> get sideSelectionBoxTitleList {
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

  List<IconData> get sideSelectionBoxIconList {
    return [
      Icons.dashboard,
      Icons.production_quantity_limits,
      Icons.point_of_sale,
      Icons.shopping_cart,
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
      screenSelectionNode_7,
    ].obs;
  }

  List<Widget> get screenList {
    return [
      DashboardScreen(),
      ProductsScreen(),
      SalesScreen(),
      PurchaseScreen(),
      CustomersScreen(),
      ReportsScreen(),
      SettingsScreen(),
    ].obs;
  }

  List<Widget> get mobileScreenList {
    return [
      DashboardScreen(),
    ];
  }
}
