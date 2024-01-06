import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pos_fyp/res/app_color.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {required this.text,
      required this.onPress,
      required this.buttonStyle,
      this.focusNode,
      this.isLoading = false,
      super.key});

  final String text;
  final VoidCallback? onPress;
  final ButtonStyle buttonStyle;
  final FocusNode? focusNode;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        focusNode: focusNode,
        onPressed: isLoading ? null : onPress,
        style: buttonStyle,
        child: isLoading
            ? const SpinKitFadingCircle(color: AppColors.blackColor, size: 25)
            : Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
      ),
    );
  }
}
