import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/reset_password/reset_password_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/components/custom_progress_indicator.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller = Get.find<ResetPasswordController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    ImageAssets.thoughtful,
                    width: Get.width,
                    height: Get.height * 0.32,
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Text('Forgot your password?',
                      style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                  Text('Confirm your email and we\'ll send you the link to reset your password',
                      style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center),
                  SizedBox(height: Get.height * 0.02),
                  TextFormField(
                    controller: controller.resetPasswordController,
                    decoration: kLoginInputFieldDecoration.copyWith(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.person_outline),
                      suffixIconConstraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
                      suffixIcon: Obx(
                        () => controller.isWatching.value
                            ? const CircularProgressIndicator(strokeWidth: 3, color: AppColors.appButtonColor)
                            : Visibility(
                                visible: controller.isVisible.value,
                                child: const Icon(Icons.check, color: AppColors.greenColor),
                              ),
                      ),
                    ),
                    onChanged: (v) {
                      controller.checkTimers();
                      controller.textTimer = Timer(const Duration(milliseconds: 300), () {
                        controller.watchPassword(controller.resetPasswordController.text.trim());
                      });
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(
                    () => TextButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              controller.resetPassword();
                            },
                      style: TextButton.styleFrom(backgroundColor: AppColors.appButtonColor),
                      child: controller.isLoading.value
                          ? CustomProgressIndicator(width: 20, height: 20, color: AppColors.whiteColor)
                          : Text(
                              'Reset Password',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
                            ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  InkWell(
                      onTap: () => Get.offAllNamed(RouteName.loginScreen),
                      child: const Text(
                        '<\t Back to Login',
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
