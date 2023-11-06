import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/signup_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/mobile/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());
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
                      'Create an account',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: Get.height * .04),
                    TextInputField(
                      myController: signupController.emailController,
                      myFocusNode: signupController.emailFocusNode,
                      nextFocusNode: signupController.passwordFocusNode,
                      labelText: 'Email',
                      validator: (v) {
                        if (!GetUtils.isEmail(v.toString())) {
                          return 'Invalid email address';
                        }
                      },
                    ),
                    SizedBox(height: Get.height * .04),
                    TextInputField(
                      myController: signupController.passwordController,
                      myFocusNode: signupController.passwordFocusNode,
                      nextFocusNode: signupController.createAccButtonFocusNode,
                      labelText: 'Password',
                      validator: (v) {
                        if (GetUtils.isLengthLessOrEqual(v.toString(), 4)) {
                          return 'Password length must be greater than 4 characters';
                        }
                      },
                    ),
                    SizedBox(height: Get.height * .02),
                    TextButton(
                      focusNode: signupController.createAccButtonFocusNode,
                      onPressed: () {
                        print('pressed');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.appButtonColor,
                      ),
                      child: const Text('Create', style: TextStyle(color: AppColors.whiteColor)),
                    ),
                    SizedBox(height: Get.height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(RouteName.loginScreen);
                          },
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text('Login', style: TextStyle(color: AppColors.blackColor)),
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
