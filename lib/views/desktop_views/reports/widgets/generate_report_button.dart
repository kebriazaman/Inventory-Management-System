import 'package:flutter/material.dart';

import '../../../../res/app_color.dart';

class GenerateReportButton extends StatelessWidget {
  GenerateReportButton({required this.title, required this.onPress, required this.focusNode, super.key});
  String title;
  VoidCallback onPress;
  FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      focusNode: focusNode,
      onPressed: onPress,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
      child: Text(title, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.whiteColor)),
    );
  }
}
