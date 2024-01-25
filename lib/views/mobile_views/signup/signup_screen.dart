import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/signup_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/mobile_views/signup/widgets/signup_rounded_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: signupController.signupFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Create Account,',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: Get.height * .01),
                    Text(
                      textAlign: TextAlign.center,
                      'Register with valid email address!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600, color: AppColors.blackColor.withOpacity(0.5)),
                    ),
                    SizedBox(height: Get.height * .04),
                    TextFormField(
                      controller: signupController.emailController,
                      focusNode: signupController.emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kTextInputFieldDecoration.copyWith(
                          hintText: 'Email', prefixIcon: const Icon(Icons.email_outlined)),
                      onFieldSubmitted: (_) => Utils.fieldFocusChange(
                          context, signupController.emailFocusNode, signupController.passwordFocusNode),
                      textInputAction: TextInputAction.next,
                      validator: (v) => !GetUtils.isEmail(v.toString()) ? 'Please enter valid email' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: Get.height * .04),
                    Obx(
                      () => TextFormField(
                        obscureText: signupController.obscurePassword.value,
                        controller: signupController.passwordController,
                        focusNode: signupController.passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: kTextInputFieldDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_reset),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                signupController.obscurePassword.value = !signupController.obscurePassword.value,
                            icon: signupController.obscurePassword.value
                                ? const Icon(Icons.visibility, color: AppColors.blackColor, size: 20)
                                : const Icon(Icons.visibility_off, color: AppColors.blackColor, size: 20),
                          ),
                        ),
                        onFieldSubmitted: (_) => Utils.fieldFocusChange(context,
                            signupController.passwordFocusNode, signupController.createAccButtonFocusNode),
                        validator: (v) => GetUtils.isLengthLessThan(v.toString(), 8)
                            ? 'Password must be at least 8 characters long'
                            : null,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(height: Get.height * .03),
                    Obx(
                      () => SignupRoundedButton(
                          title: 'Register',
                          focusNode: signupController.createAccButtonFocusNode,
                          onPress: () {
                            if (signupController.signupFormKey.currentState!.validate()) {
                              signupController.createAccount();
                            }
                          },
                          isLoading: signupController.isLoading.value),
                    ),
                    SizedBox(height: Get.height * .02),
                    InkWell(
                      onTap: () => Get.offNamed(RouteName.loginScreen),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'I\'m already a member, ',
                            children: [
                              TextSpan(
                                  text: 'Login',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      decoration: TextDecoration.underline, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
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
