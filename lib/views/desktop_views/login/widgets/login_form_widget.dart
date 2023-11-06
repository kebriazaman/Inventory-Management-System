import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/res/components/dashboard/round_button.dart';
import 'package:pos_fyp/res/components/dashboard/text_input_field.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';

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
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Login to your account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: Get.height * 0.05),
              TextInputField(
                myController: loginController.userNameController,
                currentFocusNode: loginController.userNameFocusNode,
                nextFocusNode: loginController.passwordFocusNode,
                textFormFieldDecoration: kLoginInputFieldDecoration,
              ),
              SizedBox(height: Get.height * 0.03),
              Obx(
                () => TextInputField(
                  myController: loginController.passwordController,
                  currentFocusNode: loginController.passwordFocusNode,
                  nextFocusNode: loginController.buttonFocusNode,
                  obscurePassword: loginController.obscurePassword.value,
                  textFormFieldDecoration: kLoginInputFieldDecoration.copyWith(
                      labelText: 'Enter your password',
                      suffixIcon: loginController.obscurePassword.value == true
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                  onTap: () => loginController.obscurePassword.value = !loginController.obscurePassword.value,
                  validator: (value) {
                    if (GetUtils.isLengthLessOrEqual(value, 6)) {
                      return 'Invalid password';
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Checkbox(
                          side: BorderSide.none,
                          value: loginController.isChecked.value,
                          onChanged: (v) {
                            loginController.isChecked.value = v!;
                          },
                          fillColor: MaterialStateProperty.all(Colors.white38),
                          checkColor: Colors.black38,
                          splashRadius: 0.0,
                        ),
                      ),
                      const Text('Remember me')
                    ],
                  ),
                  RoundButton(
                    myFocusNode: loginController.buttonFocusNode,
                    title: 'LOG IN',
                    onPressed: () {
                      if (loginController.loginFormKey.currentState!.validate()) {
                        Get.offNamed(RouteName.desktopScreen);
                      } else {
                        print('Invalid email or password');
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
