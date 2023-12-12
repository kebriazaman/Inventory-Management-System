import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    redirectTo();
  }

  ParseUser? _parseUser;

  final _isLoading = false.obs;
  final _loginFormKey = GlobalKey<FormState>();
  final _isChecked = false.obs;
  final _obscurePassword = true.obs;
  final _isLoggedIn = false.obs;

  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  RxBool get obscurePassword => _obscurePassword;
  RxBool get isChecked => _isChecked;
  RxBool get isLoggedIn => _isLoggedIn;
  RxBool get isLoading => _isLoading;

  ParseUser? get parseUser => _parseUser;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> initUser() async {
    _parseUser = await ParseUser.currentUser();
  }

  Future<void> userLogin(BuildContext context) async {
    isLoading.value = true;
    try {
      String userName = emailController.text.trim();
      String password = passwordController.text.trim();
      final user = ParseUser(userName, password, null);
      var response = await user.login();
      if (response.success) {
        isLoading.value = false;
        Get.offNamed(RouteName.desktopScreen);
      } else {
        Utils.showDialogueBox(context, 'Error', response.error!.message, Icon(Icons.error));
        isLoading.value = false;
      }
    } catch (e) {
      Utils.showDialogueBox(context, 'Error', 'User not logged in', Icon(Icons.error));
    }
  }

  Future<void> redirectTo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstSeen = sharedPreferences.getBool('showOnboardScreen') ?? false;
    isFirstSeen ? Get.offAllNamed(RouteName.loginScreen) : Get.offNamed(RouteName.onboardingScreen);
  }
}
