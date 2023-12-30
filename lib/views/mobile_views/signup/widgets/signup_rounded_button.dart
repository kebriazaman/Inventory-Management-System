import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/custom_progress_indicator.dart';

class SignupRoundedButton extends StatelessWidget {
  SignupRoundedButton({
    required this.title,
    required this.focusNode,
    required this.onPress,
    required this.isLoading,
    super.key,
  });

  String title;
  bool isLoading;
  VoidCallback onPress;
  FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      onPressed: onPress,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: AppColors.appButtonColor,
      ),
      child: isLoading
          ? CustomProgressIndicator(width: 20, height: 20, color: AppColors.whiteColor)
          : Text(title, style: const TextStyle(color: AppColors.whiteColor)),
    );
  }
}
