import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/routes/app_routes.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/back4app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Back4App.initParse();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return GetMaterialApp(
      scrollBehavior:
          const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
      themeMode: ThemeMode.system,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.whiteColor,
          appBarTheme: const AppBarTheme(surfaceTintColor: AppColors.whiteColor, color: AppColors.whiteColor)),
      debugShowCheckedModeBanner: false,
      initialRoute: loginController.isFirstSeen.value ? RouteName.loginScreen : RouteName.onboardingScreen,
      getPages: AppRoutes.appRoutes(context),
    );
  }
}
