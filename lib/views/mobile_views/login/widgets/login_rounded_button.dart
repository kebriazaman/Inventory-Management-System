import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class LoginRoundedButton extends StatelessWidget {
  LoginRoundedButton({
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
          ? const Center(
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.whiteColor)))
          : const Text('Login', style: TextStyle(color: AppColors.whiteColor)),
    );
  }
}
