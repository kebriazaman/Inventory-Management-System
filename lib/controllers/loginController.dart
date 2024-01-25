import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();
  @override
  void onInit() {
    super.onInit();
    // To initialize preferences in order to where to go
    initPreferences();

    // To check if user is null or not
    initUser();

    // To check the remember me
    getLoginCredentials();
  }

  ParseUser? _parseUser;
  final _isLoading = false.obs;
  final RxBool _isFirstSeen = false.obs;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mobileLoginFormKey = GlobalKey<FormState>();
  final RxBool _isChecked = false.obs;
  final _obscurePassword = true.obs;
  final _isLoggedIn = false.obs;

  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  GlobalKey<FormState> get mobileLoginFormKey => _mobileLoginFormKey;

  RxBool get obscurePassword => _obscurePassword;
  RxBool get isChecked => _isChecked;
  RxBool get isLoggedIn => _isLoggedIn;
  RxBool get isLoading => _isLoading;
  RxBool get isFirstSeen => _isFirstSeen;

  ParseUser? get parseUser => _parseUser;

  setIsChecked(bool value) => isChecked.value = value;
  setIsFirstSeen(bool value) => _isFirstSeen.value = value;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> initUser() async {
    try {
      _parseUser = await ParseUser.currentUser();
      if (_parseUser != null) Get.offAllNamed(RouteName.mainScreen);
      Utils.showSnackBarMessage('Error', 'User is not logged in', Icons.error);
    } catch (e) {
      Utils.showSnackBarMessage('Error', e.toString(), Icons.error);
    }
  }

  Future<void> userLogin() async {
    isLoading.value = true;
    try {
      String userName = emailController.text.trim();
      String password = passwordController.text.trim();
      final user = ParseUser(userName, password, null);
      var response = await user.login();
      if (response.success && response.results != null) {
        isLoading.value = false;
        if (isChecked.value) {
          saveLoginCredentials();
        }
        Utils.showSnackBarMessage('Login Successful', 'User successfully logged in', Icons.add_alert);
        Get.offNamed(RouteName.mainScreen, arguments: {'username': user.username});
      } else {
        Utils.showSnackBarMessage('Error', response.error!.message, Icons.error_outline);
        isLoading.value = false;
      }
    } catch (e) {
      Utils.showSnackBarMessage('Error', e.toString(), Icons.error);
    }
  }

  Future<void> initPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isSeen = sharedPreferences.getBool('showOnboardScreen') ?? false;
    setIsFirstSeen(isSeen);
  }

  Future<void> getLoginCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    emailController.text = preferences.getString('email') ?? '';
    passwordController.text = preferences.getString('password') ?? '';
    setIsChecked(preferences.getBool('isChecked') ?? false);
    if (isChecked.value && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      userLogin();
    }
  }

  Future<void> saveLoginCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isChecked.value) {
      await preferences.setString('email', emailController.text.trim());
      await preferences.setString('password', passwordController.text.trim());
    } else {
      await preferences.remove('email');
      await preferences.remove('password');
    }
    await preferences.setBool('isChecked', isChecked.value);
  }
}
