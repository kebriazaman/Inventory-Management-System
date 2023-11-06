import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/utils/extensions.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showSnackBarMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: Icon(Icons.add_alert),
    ).show();
  }

  static void gainFocus(BuildContext context, FocusNode currentFocus) {
    FocusScope.of(context).requestFocus(currentFocus);
  }

  static List<Offset> generatePoints(BuildContext context) {
    final points = <Offset>[];
    final double waveHeight = 30.0;
    for (int i = 0; i <= Get.width.toInt() + 2; i++) {
      double radian = (i / Get.width) * math.pi * 9;
      double dx = i.toDouble();
      double dy = math.sin(radian) * waveHeight + Get.height / 5;
      points.add(Offset(dx, dy));
    }
    return points;
  }

  static void showDialogueBox(BuildContext context, String title, String message, Icon icon) {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)).then((value) => true),
          builder: (context, snapshot) {
            if (snapshot.hasData) Navigator.of(context).pop();
            return AlertDialog(
              title: Row(
                children: [
                  icon,
                  10.width,
                  Text(title),
                ],
              ),
              content: Text(message),
            );
          },
        );
      },
    );
  }
}
