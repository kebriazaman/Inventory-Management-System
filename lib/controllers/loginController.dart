import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/res/routes/route_name.dart';

class LoginController extends GetxController {
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

  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> initUser() async {
    _parseUser = await ParseUser.currentUser();
  }

  void userLogin(BuildContext context) async {
    isLoading.value = true;
    String userName = userNameController.text.trim();
    String password = passwordController.text.trim();
    final user = ParseUser(userName, password, null);
    var response = await user.login();
    if (response.success) {
      isLoading.value = false;
      Get.offNamed(RouteName.desktopScreen);
    } else {
      isLoading.value = false;
    }
  }
}
