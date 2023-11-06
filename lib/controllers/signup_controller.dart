import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/res/routes/route_name.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;

  final signupFormKey = GlobalKey<FormState>();

  var obscurePassword = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode createAccButtonFocusNode = FocusNode();

  void userSignup() async {
    isLoading.value = true;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    final user = ParseUser.createUser(email, password, email);
    await user.signUp().then((value) {
      isLoading.value = false;
      Get.toNamed(RouteName.desktopScreen);
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
