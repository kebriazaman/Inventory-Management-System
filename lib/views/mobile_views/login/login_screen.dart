import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome Again',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    10.height,
                    Text(
                      textAlign: TextAlign.center,
                      'Enter your email Id and password to login to your account',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    20.height,
                    TextInputField(
                      myController: loginController.emailController,
                      currentFocusNode: loginController.emailFocusNode,
                      nextFocusNode: loginController.passwordFocusNode,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(
                          contentPadding: const EdgeInsets.all(16),
                          labelText: '',
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined)),
                    ),
                    20.height,
                    Obx(
                      () => TextInputField(
                        myController: loginController.passwordController,
                        currentFocusNode: loginController.passwordFocusNode,
                        nextFocusNode: loginController.buttonFocusNode,
                        obscurePassword: loginController.obscurePassword.value,
                        textFormFieldDecoration: kTextFormFieldDecoration.copyWith(
                          hintText: 'Password',
                          labelText: '',
                          prefixIcon: const Icon(Icons.lock_reset_outlined),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                loginController.obscurePassword.value = !loginController.obscurePassword.value,
                            icon: loginController.obscurePassword.value == true
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                    20.height,
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
