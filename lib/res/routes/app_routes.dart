import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/routes/desktop_app_routes.dart';
import 'package:pos_fyp/res/routes/mobile_app_routes.dart';

class AppRoutes {
  AppRoutes._();
  static List<GetPage<dynamic>> appRoutes(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth < 400) {
      return MobileAppRoutes.appRoutes();
    } else {
      return DesktopAppRoutes.appRoutes();
    }
  }
}
