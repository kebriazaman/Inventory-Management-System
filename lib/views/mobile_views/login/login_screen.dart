import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';

import './widgets/login_rounded_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: loginController.mobileLoginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome Again,',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                    ),
                    10.height,
                    Text(
                      textAlign: TextAlign.center,
                      'Enter your email Id and password to login to your account',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600, color: AppColors.blackColor.withOpacity(0.5)),
                    ),
                    20.height,
                    TextFormField(
                      controller: loginController.emailController,
                      focusNode: loginController.emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kLoginInputFieldDecoration.copyWith(
                          hintText: 'Email', prefixIcon: const Icon(Icons.email_outlined)),
                      onFieldSubmitted: (_) => Utils.fieldFocusChange(
                          context, loginController.emailFocusNode, loginController.passwordFocusNode),
                      textInputAction: TextInputAction.next,
                      validator: (v) => !GetUtils.isEmail(v.toString()) ? 'Please enter valid email' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    20.height,
                    Obx(
                      () => TextFormField(
                        obscureText: loginController.obscurePassword.value,
                        controller: loginController.passwordController,
                        focusNode: loginController.passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: kLoginInputFieldDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_reset),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                loginController.obscurePassword.value = !loginController.obscurePassword.value,
                            icon: loginController.obscurePassword.value
                                ? const Icon(Icons.visibility, color: AppColors.blackColor)
                                : const Icon(Icons.visibility_off, color: AppColors.blackColor),
                          ),
                        ),
                        onFieldSubmitted: (_) => Utils.fieldFocusChange(
                            context, loginController.passwordFocusNode, loginController.buttonFocusNode),
                        validator: (v) => GetUtils.isLengthLessThan(v.toString(), 8)
                            ? 'Password must be at least 8 characters long'
                            : null,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  activeColor: AppColors.appButtonColor,
                                  value: loginController.isChecked.value,
                                  onChanged: (v) {
                                    loginController.isChecked.value = v!;
                                  }),
                            ),
                            Text('Remember me', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        20.width,
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.offNamed(RouteName.forgotPasswordScreen);
                            },
                            child: Text('Forgot Password?',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.redColor)),
                          ),
                        ),
                      ],
                    ),
                    20.height,
                    Obx(
                      () => LoginRoundedButton(
                        title: 'Login',
                        focusNode: loginController.buttonFocusNode,
                        onPress: () {
                          if (loginController.mobileLoginFormKey.currentState!.validate()) {
                            Utils.hideKeyboard();
                            loginController.userLogin();
                          }
                        },
                        isLoading: loginController.isLoading.value,
                      ),
                    ),
                    10.height,
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
                          child: const Text('Sign Up',
                              style: TextStyle(color: AppColors.blackColor, decoration: TextDecoration.underline)),
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
