import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget(this.title, this.value, this.imageIconPath, this.iconBackgroundColor, {super.key});

  final String title;
  final String value;
  final Color iconBackgroundColor;
  final String imageIconPath;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Expanded(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: iconBackgroundColor,
                  child: Image.asset(
                    imageIconPath,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
