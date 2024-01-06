import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/extensions.dart';

class Utils {
  static void generatePdf() async {}

  static void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showSnackBarMessage(String title, String message, IconData icon) {
    Get.snackbar(
      title,
      message,
      icon: Icon(icon),
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.blueColor.withOpacity(0.5),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static void gainFocus(BuildContext context, FocusNode currentFocus) {
    FocusScope.of(context).requestFocus(currentFocus);
  }

  static void loseFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static List<Offset> generatePoints(BuildContext context) {
    final points = <Offset>[];
    const double waveHeight = 10.0;
    for (int i = 0; i <= Get.width.toInt() + 2; i++) {
      double radian = (i / Get.width) * math.pi * 9;
      double dx = i.toDouble();
      double dy = math.sin(radian) * waveHeight + Get.height / 9;
      points.add(Offset(dx, dy));
    }
    return points;
  }

  static void showDialogueBox(BuildContext context, String title, String message, Icon icon) {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)).then((value) => true),
          builder: (context, snapshot) {
            if (snapshot.hasData) Navigator.of(context).pop();
            return AlertDialog(
              title: Column(
                children: [
                  icon,
                  10.width,
                  Text(textAlign: TextAlign.center, title),
                ],
              ),
              content: Text(message),
            );
          },
        );
      },
    );
  }

  static void showDialogueMessage(String title, String message, IconData icon) {
    Get.defaultDialog(
      radius: 10.0,
      backgroundColor: AppColors.whiteColor,
      title: title,
      content: SizedBox(
        width: Get.width * 0.3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            10.width,
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
