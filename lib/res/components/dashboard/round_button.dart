import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.myFocusNode,
    required this.title,
    required this.onPressed,
    this.isLoading,
    super.key,
  });

  final FocusNode myFocusNode;
  final String title;
  final VoidCallback onPressed;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: myFocusNode,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(Get.width * 0.2, 48.0),
        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 20.0),
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
      child: isLoading == true
          ? SizedBox(
              height: 48.0,
              width: 30.0,
              child: const CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2))
          : Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
