import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.orientation,
    super.key,
  });
  final String title, subtitle, imageUrl;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.contain,
            width: orientation == Orientation.landscape ? Get.width * 0.5 : Get.width,
            height: orientation == Orientation.landscape ? Get.height * 0.45 : Get.height * 0.4,
          ),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Text(
            subtitle,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
