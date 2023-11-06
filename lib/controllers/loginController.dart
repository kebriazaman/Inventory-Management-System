import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/res/routes/route_name.dart';

class LoginController extends GetxController {
  final _loginFormKey = GlobalKey<FormState>();
  final _isChecked = false.obs;
  final _obscurePassword = true.obs;
  final _isLoggedIn = false.obs;

  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  RxBool get obscurePassword => _obscurePassword;
  RxBool get isChecked => _isChecked;
  RxBool get isLoggedIn => _isLoggedIn;

  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void userLogin() async {
    String userName = userNameController.text.trim();
    String password = passwordController.text.trim();
    final user = ParseUser(userName, password, null);
    var response = await user.login();
    if (response.success) {
      Get.offNamed(RouteName.dashboardScreen);
    } else {
      print('Unable to login');
    }
  }
}
