import 'package:flutter/material.dart';
import 'package:pos_fyp/controllers/mobile/onboarding_controller.dart';
import 'package:pos_fyp/res/app_color.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    super.key,
    required this.title,
    required this.onboardingController,
  });

  final OnboardingController onboardingController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onboardingController.skipPageNavigation,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 24.0),
        child: Text(
          textAlign: TextAlign.right,
          'Skip',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.blueColor),
        ),
      ),
    );
  }
}
