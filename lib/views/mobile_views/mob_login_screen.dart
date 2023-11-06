import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/mobile/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      'Login',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: Get.height * .04),
                    TextInputField(
                      myController: loginController.userNameController,
                      myFocusNode: loginController.userNameFocusNode,
                      nextFocusNode: loginController.passwordFocusNode,
                      labelText: 'User name',
                    ),
                    SizedBox(height: Get.height * .04),
                    TextInputField(
                      myController: loginController.passwordController,
                      myFocusNode: loginController.passwordFocusNode,
                      nextFocusNode: loginController.buttonFocusNode,
                      labelText: 'Password',
                    ),
                    SizedBox(height: Get.height * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (v) {}),
                            const Text('Remember me'),
                          ],
                        ),
                        SizedBox(height: Get.height * .02),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password', style: TextStyle(color: AppColors.redColor)),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * .02),
                    TextButton(
                      focusNode: loginController.buttonFocusNode,
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.appButtonColor,
                      ),
                      child: const Text('Login', style: TextStyle(color: AppColors.whiteColor)),
                    ),
                    SizedBox(height: Get.height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(RouteName.signupScreen);
                          },
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            padding: const EdgeInsets.all(0),
                          ),
                          child: const Text('Sign Up', style: TextStyle(color: AppColors.blackColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
