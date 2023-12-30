import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/round_button.dart';
import 'package:pos_fyp/res/components/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Container(
      color: Colors.black12,
      child: Form(
        key: loginController.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Login to your account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: Get.height * 0.05),
              TextInputField(
                myController: loginController.emailController,
                currentFocusNode: loginController.emailFocusNode,
                nextFocusNode: loginController.passwordFocusNode,
                keyboardType: TextInputType.emailAddress,
                textFormFieldDecoration: kLoginInputFieldDecoration,
                validator: (value) => !GetUtils.isEmail(value!) ? 'Enter valid email' : null,
              ),
              SizedBox(height: Get.height * 0.03),
              Obx(
                () => TextInputField(
                  myController: loginController.passwordController,
                  currentFocusNode: loginController.passwordFocusNode,
                  nextFocusNode: loginController.buttonFocusNode,
                  obscurePassword: loginController.obscurePassword.value,
                  keyboardType: TextInputType.visiblePassword,
                  textFormFieldDecoration: kLoginInputFieldDecoration.copyWith(
                    labelText: 'Enter your password',
                    suffixIcon: IconButton(
                      onPressed: () => loginController.obscurePassword.value = !loginController.obscurePassword.value,
                      icon: loginController.obscurePassword.value == true
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                  onTap: () => loginController.obscurePassword.value = !loginController.obscurePassword.value,
                  validator: (value) => GetUtils.isLengthLessThan(value, 8) ? 'Password is incorrect' : null,
                ),
              ),
              20.height,
              InkWell(
                splashColor: AppColors.transparentColor,
                hoverColor: AppColors.transparentColor,
                highlightColor: AppColors.transparentColor,
                onTap: () => Get.toNamed(RouteName.forgotPasswordScreen),
                child: Text(
                    textAlign: TextAlign.right,
                    'Forgot Password',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.redColor, decoration: TextDecoration.underline)),
              ),
              20.height,
              Obx(
                () => RoundButton(
                  isLoading: loginController.isLoading.value,
                  myFocusNode: loginController.buttonFocusNode,
                  title: 'LOG IN',
                  onPressed: () {
                    if (loginController.loginFormKey.currentState!.validate()) {
                      loginController.userLogin();
                    }
                  },
                ),
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No account yet?'),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Get.offNamed(RouteName.signupScreen);
                    },
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
