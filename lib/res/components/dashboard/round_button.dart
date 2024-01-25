import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.myFocusNode,
    required this.title,
    this.onPressed,
    this.isLoading,
    this.width = 120.0,
    this.height = 40.0,
    super.key,
  });

  final FocusNode myFocusNode;
  final String title;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: myFocusNode,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
      child: isLoading == true
          ? const SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2))
          : Text(title, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.whiteColor)),
    );
  }
}
