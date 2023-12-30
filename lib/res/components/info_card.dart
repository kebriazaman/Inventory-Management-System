import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(this.title, this.value, this.imageIconPath, this.iconBackgroundColor, {super.key});
  final String title;
  final int value;
  final Color iconBackgroundColor;
  final String imageIconPath;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        surfaceTintColor: AppColors.whiteColor,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400)),
                  Text(value.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
              const Spacer(),
              Expanded(
                child: CircleAvatar(
                    radius: 25,
                    backgroundColor: iconBackgroundColor,
                    child: Image.asset(imageIconPath, width: 25, height: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
