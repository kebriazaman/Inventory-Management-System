import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/signup_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/round_button.dart';
import 'package:pos_fyp/res/components/dashboard/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final signupController = Get.find<SignupController>();
    return Form(
      key: signupController.signupFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Create Account', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            SizedBox(height: Get.height * .05),
            TextInputField(
              myController: signupController.emailController,
              currentFocusNode: signupController.emailFocusNode,
              nextFocusNode: signupController.passwordFocusNode,
              textFormFieldDecoration: kSignupInputFieldDecoration,
              validator: (v) {
                if (!GetUtils.isEmail(v.toString())) {
                  return 'Invalid email entered';
                }
              },
            ),
            SizedBox(height: Get.height * .03),
            Obx(
              () => TextInputField(
                obscurePassword: signupController.obscurePassword.value,
                myController: signupController.passwordController,
                currentFocusNode: signupController.passwordFocusNode,
                nextFocusNode: signupController.createAccButtonFocusNode,
                textFormFieldDecoration: kSignupInputFieldDecoration.copyWith(
                  suffixIcon: IconButton(
                    onPressed: () => signupController.obscurePassword.value = !signupController.obscurePassword.value,
                    icon: signupController.obscurePassword.value == true
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  hintText: 'Enter your Password',
                ),
                validator: (v) {
                  if (!GetUtils.isLengthGreaterOrEqual(v, 8)) {
                    return 'Password must be at least 8 characters long';
                  }
                },
              ),
            ),
            SizedBox(height: Get.height * .05),
            Obx(
              () => Center(
                child: signupController.isLoading.value == true
                    ? const CircularProgressIndicator()
                    : RoundButton(
                        myFocusNode: signupController.createAccButtonFocusNode,
                        title: 'Create Account',
                        onPressed: () {
                          if (signupController.signupFormKey.currentState!.validate()) {
                            signupController.userSignup();
                          } else {
                            print('Invalid data entered');
                          }
                        },
                      ),
              ),
            ),
            SizedBox(height: Get.height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.offNamed(RouteName.loginScreen);
                  },
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.appButtonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
