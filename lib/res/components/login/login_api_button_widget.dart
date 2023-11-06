import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';

class LoginAPIButtonWidget extends StatelessWidget {
  const LoginAPIButtonWidget({required this.buttonTitle, required this.iconImagePath, Key? key}) : super(key: key);

  final String buttonTitle;
  final String iconImagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Button Tapped');
      },
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: Get.width * 0.15,
        height: Get.height * 0.07,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconImagePath, width: 25, height: 25),
            const SizedBox(width: 10),
            Text(buttonTitle),
          ],
        ),
      ),
    );
  }
}
