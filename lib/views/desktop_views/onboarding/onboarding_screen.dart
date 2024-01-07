import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/onboarding_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/round_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.put(OnboardingController());
    return Scaffold(
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onboardingController.getImageList[onboardingController.currentPageIndex.value]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 5),
              child: Text(
                onboardingController.getTitlesList[onboardingController.currentPageIndex.value],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 5),
              child: Text(
                onboardingController.getSubtitlesList[onboardingController.currentPageIndex.value],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
              child: Obx(
                () => RoundButton(
                  title: onboardingController.currentPageIndex.value < 2 ? 'Next' : 'Get Started',
                  onPressed: () {
                    onboardingController.nextPage();
                  },
                  myFocusNode: FocusNode(),
                  width: 200,
                ),
              ),
            ),
            SizedBox(
              height: 20,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: onboardingController.getImageList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          width: onboardingController.currentPageIndex.value == index ? 20 : 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
