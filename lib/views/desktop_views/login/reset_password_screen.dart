import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/reset_password/reset_password_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/round_button_widget.dart';
import 'package:pos_fyp/res/components/text_input_field.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final resetPasswordController = Get.find<ResetPasswordController>();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor4,
      body: Center(
        child: Container(
          width: Get.width * 0.5,
          height: Get.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            boxShadow: const [
              BoxShadow(color: AppColors.greyColor, blurRadius: 10),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
            child: Column(
              children: [
                Icon(
                  Icons.lock_reset_outlined,
                  size: Get.width * 0.04,
                ),
                Text('Forgot Password', style: Theme.of(context).textTheme.headlineSmall),
                10.height,
                Text('Enter your email and we will send a link to reset your password',
                    style: Theme.of(context).textTheme.bodyMedium),
                10.height,
                TextInputField(
                  myController: resetPasswordController.resetPasswordController,
                  currentFocusNode: resetPasswordController.resetPasswordFocusNode,
                  nextFocusNode: resetPasswordController.resetButtonFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Email'),
                ),
                20.height,
                RoundButtonWidget(
                  title: 'Submit',
                  isLoading: true,
                  onTap: () => resetPasswordController.resetPassword(),
                  backgroundColor: AppColors.greenColor,
                  textColor: AppColors.whiteColor,
                ),
                20.height,
                InkWell(
                  onTap: () {
                    // loginController.resetPasswordController.clear();
                    Get.back();
                  },
                  child: Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      text: '<\t',
                      children: const [
                        TextSpan(text: 'Back to Login'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
