import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/signup_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/round_button.dart';
import 'package:pos_fyp/res/components/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/debouncer.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Create Account', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Obx(
                  () => signupController.isMatched.value
                      ? DropdownButton(
                          elevation: 0,
                          focusColor: AppColors.transparentColor,
                          underline: const SizedBox.shrink(),
                          value: signupController.roleValue.value,
                          items: signupController.rolesDropdownList.map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: signupController.isEnable.value
                              ? (v) {
                                  signupController.setRoleValue(v.toString());
                                }
                              : null,
                        )
                      : const SpinKitFadingCircle(
                          color: AppColors.blueColor,
                          size: 30,
                        ),
                )
              ],
            ),
            SizedBox(height: Get.height * .05),
            TextInputField(
              myController: signupController.emailController,
              currentFocusNode: signupController.emailFocusNode,
              nextFocusNode: signupController.passwordFocusNode,
              keyboardType: TextInputType.emailAddress,
              textFormFieldDecoration: kTextInputFieldDecoration,
              validator: (v) => !GetUtils.isEmail(v!) ? 'Enter valid email' : null,
              onSubmit: (v) => Utils.fieldFocusChange(
                context,
                signupController.emailFocusNode,
                signupController.passwordFocusNode,
              ),
              onChange: (v) {
                Debouncer(millisecs: 2000).run(() {
                  signupController.checkEmail(v.toString());
                });
              },
            ),
            SizedBox(height: Get.height * .05),
            Obx(
              () => TextInputField(
                obscurePassword: !signupController.obscurePassword.value,
                myController: signupController.passwordController,
                currentFocusNode: signupController.passwordFocusNode,
                nextFocusNode: signupController.createAccButtonFocusNode,
                keyboardType: TextInputType.visiblePassword,
                onSubmit: (v) => Utils.fieldFocusChange(
                    context, signupController.passwordFocusNode, signupController.createAccButtonFocusNode),
                textFormFieldDecoration: kTextInputFieldDecoration.copyWith(
                  suffixIcon: IconButton(
                    onPressed: () =>
                        signupController.obscurePassword.value = !signupController.obscurePassword.value,
                    icon: signupController.obscurePassword.value == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  hintText: 'Enter your Password',
                ),
                validator: (v) =>
                    !GetUtils.isLengthGreaterOrEqual(v, 8) ? 'Password must be at least 8 characters long' : null,
              ),
            ),
            SizedBox(height: Get.height * .05),
            Obx(
              () => RoundButton(
                isLoading: signupController.isLoading.value,
                myFocusNode: signupController.createAccButtonFocusNode,
                title: 'Create Account',
                onPressed: signupController.isLoading.value
                    ? null
                    : () {
                        // signupController.setUserACL();
                        signupController.createAccount();
                        if (signupController.signupFormKey.currentState!.validate()) {}
                      },
              ),
            ),
            SizedBox(height: Get.height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                10.width,
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
