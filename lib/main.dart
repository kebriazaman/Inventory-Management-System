import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/routes/app_routes.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/back4app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Back4App.initParse();
  Get.put(LoginController()).initUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: _loginController.parseUser == null ? RouteName.loginScreen : RouteName.desktopScreen,
      getPages: AppRoutes().appRoutes(context),
    );
  }
}
