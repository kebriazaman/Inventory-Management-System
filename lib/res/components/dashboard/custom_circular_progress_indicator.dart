import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFormFieldBorderColor),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.blackColor),
      ),
    );
  }
}
