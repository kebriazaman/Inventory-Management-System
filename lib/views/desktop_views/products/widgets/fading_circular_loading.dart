import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';

class FadingCircularLoading extends StatelessWidget {
  const FadingCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Get.width * 0.01),
      child: const SizedBox(width: 20.0, child: SpinKitFadingCircle(color: AppColors.blackColor, size: 30)),
    );
  }
}
