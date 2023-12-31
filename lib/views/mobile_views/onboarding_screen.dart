import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/imageCarouselController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/round_button_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ImageCarouselController imageCarouselController = Get.put(ImageCarouselController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.3,
                    child: CarouselSlider(
                      items: imageCarouselController.imageList
                          .map(
                            (item) => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(item.toString()),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            imageCarouselController.currentIndex.value = index;
                          }),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(
                    () {
                      String text =
                          imageCarouselController.textList[imageCarouselController.currentIndex.value].toString();
                      return Text(textAlign: TextAlign.center, text);
                    },
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < imageCarouselController.imageList.length; i++)
                        Obx(
                          () => Container(
                            height: 4,
                            width: imageCarouselController.currentIndex.value == i ? 18 : 18,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color: imageCarouselController.currentIndex.value == i ? Colors.blue : Colors.white,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.lightGreyColor4,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.08),
                  RoundButtonWidget(
                    title: 'Create new Account',
                    isLoading: false,
                    onTap: () {},
                    backgroundColor: AppColors.appButtonColor,
                    textColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: Get.height * 0.03),
                  RoundButtonWidget(
                    title: 'Login',
                    isLoading: false,
                    onTap: () {},
                    backgroundColor: AppColors.whiteColor,
                    textColor: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
