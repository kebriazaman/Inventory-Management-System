import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/bindings/login_binding.dart';
import 'package:pos_fyp/res/bindings/nav_binding.dart';
import 'package:pos_fyp/res/bindings/product_binding.dart';
import 'package:pos_fyp/res/bindings/signup_binding.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/views/desktop_views/dashboard/dashboard_screen.dart';
import 'package:pos_fyp/views/desktop_views/desktop_screen.dart';
import 'package:pos_fyp/views/desktop_views/login/login_screen.dart';
import 'package:pos_fyp/views/desktop_views/products/products_screen.dart';
import 'package:pos_fyp/views/desktop_views/signup/SignupScreen.dart';
import 'package:pos_fyp/views/mobile_views/mob_login_screen.dart';
import 'package:pos_fyp/views/mobile_views/mob_signup_screen.dart';
import 'package:pos_fyp/views/mobile_views/onboarding_screen.dart';
import 'package:pos_fyp/views/tablet_views/tab_desktop_screen.dart';

class AppRoutes {
  List<GetPage> desktopAppRoutes() => [
        // define routes using getx
        GetPage(
          name: RouteName.signupScreen,
          page: () => const SignupScreen(),
          transition: Transition.leftToRight,
          binding: SignupBinding(),
        ),
        GetPage(
          name: RouteName.desktopScreen,
          page: () => DesktopScreen(),
          transition: Transition.downToUp,
          bindings: [NavBinding(), ProductBinding()],
        ),
        GetPage(name: RouteName.dashboardScreen, page: () => DashboardScreen(), transition: Transition.zoom),
        GetPage(name: RouteName.productsScreen, page: () => ProductsScreen(), binding: ProductBinding()),
        GetPage(name: RouteName.loginScreen, page: () => const LoginScreen(), binding: LoginBinding()),
      ];

  List<GetPage> mobileAppRoutes() => [
        GetPage(
            name: RouteName.signupScreen, page: () => const MobileSignupScreen(), transition: Transition.leftToRight),
        GetPage(name: RouteName.loginScreen, page: () => const MobileLoginScreen(), transition: Transition.leftToRight),
        GetPage(
            name: RouteName.onboardingScreen, page: () => const OnbaordingScreen(), transition: Transition.leftToRight),
      ];

  List<GetPage> tabletAppRoutes() => [
        GetPage(name: RouteName.dashboardScreen, page: () => const TabDesktopScreen(), transition: Transition.downToUp),
      ];

  List<GetPage<dynamic>> appRoutes(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth < 400) {
      return mobileAppRoutes();
    } else if (screenWidth < 1100) {
      return tabletAppRoutes();
    } else {
      return desktopAppRoutes();
    }
  }
}
