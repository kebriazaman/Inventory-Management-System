import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    super.key,
  });
  final String title, subtitle, imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: Get.width * 0.8,
            height: Get.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                repeat: ImageRepeat.noRepeat,
                image: AssetImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Text(subtitle, maxLines: 3, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
