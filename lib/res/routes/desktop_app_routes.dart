import 'package:get/get.dart';
import 'package:pos_fyp/res/bindings/login_binding.dart';
import 'package:pos_fyp/res/bindings/nav_binding.dart';
import 'package:pos_fyp/res/bindings/product_binding.dart';
import 'package:pos_fyp/res/bindings/reset_pass_binding.dart';
import 'package:pos_fyp/res/bindings/signup_binding.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/views/desktop_views/dashboard/dashboard_screen.dart';
import 'package:pos_fyp/views/desktop_views/login/login_screen.dart';
import 'package:pos_fyp/views/desktop_views/login/reset_password_screen.dart';
import 'package:pos_fyp/views/desktop_views/main/main_screen.dart';
import 'package:pos_fyp/views/desktop_views/onboarding/onboarding_screen.dart';
import 'package:pos_fyp/views/desktop_views/products/products_screen.dart';
import 'package:pos_fyp/views/desktop_views/signup/signup_screen.dart';

class DesktopAppRoutes {
  DesktopAppRoutes._();
  static List<GetPage> appRoutes() => [
        GetPage(
          name: RouteName.onboardingScreen,
          page: () => const OnboardingScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RouteName.signupScreen,
          page: () => const SignupScreen(),
          transition: Transition.leftToRight,
          binding: SignupBinding(),
        ),
        GetPage(
          name: RouteName.mainScreen,
          page: () => MainScreen(),
          transition: Transition.downToUp,
          bindings: [NavBinding(), ProductBinding()],
        ),
        GetPage(
          name: RouteName.dashboardScreen,
          page: () => DashboardScreen(),
          transition: Transition.zoom,
          binding: NavBinding(),
        ),
        GetPage(name: RouteName.productsScreen, page: () => const ProductsScreen(), binding: ProductBinding()),
        GetPage(name: RouteName.loginScreen, page: () => const LoginScreen(), binding: LoginBinding()),
        GetPage(
            name: RouteName.forgotPasswordScreen,
            page: () => const ResetPasswordScreen(),
            binding: ResetPasswordBinding()),
      ];
}
