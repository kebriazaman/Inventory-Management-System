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
  final controller = Get.put(LoginController());
  controller.initUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.whiteColor),
      debugShowCheckedModeBanner: false,
      initialRoute: loginController.parseUser == null ? RouteName.loginScreen : RouteName.desktopScreen,
      getPages: AppRoutes.appRoutes(context),
    );
  }
}
