import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/models/onboarding_model.dart';
import 'package:pos_fyp/res/app_text/app_text.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentPageIndex = 0.obs;

  final contents = [
    OnboardingModel(
      title: AppText.onboardTitle1,
      description: AppText.onboardPara1,
      imageUrl: ImageAssets.posImage1,
    ),
    OnboardingModel(
      title: AppText.onboardTitle2,
      description: AppText.onboardPara2,
      imageUrl: ImageAssets.posImage2,
    ),
    OnboardingModel(
      title: AppText.onboardTitle3,
      description: AppText.onboardPara3,
      imageUrl: ImageAssets.posImage3,
    ),
  ];

  void onPageChanged(index) => currentPageIndex.value = index;

  void onDotClicked(int index) {
    currentPageIndex.value = index;
    pageController.jumpTo(double.parse('index'));
  }

  void skipPageNavigation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getBool('showOnboardScreen'));
    await sharedPreferences.setBool('showOnboardScreen', true);
    Get.offAllNamed(RouteName.loginScreen);
  }

  void nextPage() async {
    if (currentPageIndex.value == 2) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('showOnboardScreen', true);
      print(sharedPreferences.getBool('showOnboardScreen'));
      Get.offAllNamed(RouteName.loginScreen);
    } else {
      currentPageIndex.value += 1;
      pageController.jumpToPage(currentPageIndex.value);
    }
  }
}
