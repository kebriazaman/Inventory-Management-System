import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/mobile/onboarding_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/round_button.dart';
import 'package:pos_fyp/views/mobile_views/login/onboarding/widgets/onboarding_page.dart';
import 'package:pos_fyp/views/mobile_views/login/onboarding/widgets/onboarding_skip_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.put(OnboardingController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingSkipButton(title: 'Skip', onboardingController: onboardingController),
            Expanded(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return PageView.builder(
                    itemCount: onboardingController.contents.length,
                    onPageChanged: onboardingController.onPageChanged,
                    controller: onboardingController.pageController,
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        title: onboardingController.contents[index].title.toString(),
                        subtitle: onboardingController.contents[index].description.toString(),
                        imageUrl: onboardingController.contents[index].imageUrl.toString(),
                        orientation: orientation,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    onDotClicked: onboardingController.onDotClicked,
                    controller: onboardingController.pageController,
                    count: onboardingController.contents.length,
                    effect: const ExpandingDotsEffect(activeDotColor: AppColors.blackColor, dotHeight: 6, dotWidth: 10),
                  ),
                  Obx(
                    () => RoundButton(
                      myFocusNode: FocusNode(),
                      title: onboardingController.currentPageIndex.value != 2 ? 'Next' : 'Get Started',
                      onPressed: onboardingController.nextPage,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
