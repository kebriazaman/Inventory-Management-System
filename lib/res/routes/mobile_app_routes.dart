import 'package:get/get.dart';
import 'package:pos_fyp/res/bindings/reset_pass_binding.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/views/mobile_views/login/login_screen.dart';
import 'package:pos_fyp/views/mobile_views/login/onboarding/onboarding_screen.dart';
import 'package:pos_fyp/views/mobile_views/login/reset_password_screen.dart';
import 'package:pos_fyp/views/mobile_views/main_screen.dart';
import 'package:pos_fyp/views/mobile_views/signup/signup_screen.dart';

class MobileAppRoutes {
  MobileAppRoutes._();
  static List<GetPage> appRoutes() => [
        GetPage(
          name: RouteName.signupScreen,
          page: () => const SignupScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => const LoginScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RouteName.onboardingScreen,
          page: () => const OnboardingScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RouteName.mainScreen,
          page: () => const MainScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RouteName.forgotPasswordScreen,
          page: () => const ResetPasswordScreen(),
          transition: Transition.leftToRight,
          binding: ResetPasswordBinding(),
        ),
      ];
}
