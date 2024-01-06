import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/loginController.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();
    final loginController = Get.find<LoginController>();
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.1,
          margin: const EdgeInsets.all(16.0),
          child: CircleAvatar(radius: 20, child: Image.asset(ImageAssets.thoughtful)),
        ),
        Text(loginController.parseUser!.username.toString()),
        const Divider(indent: 20, endIndent: 20),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: navigationController.iconsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                child: Obx(
                  () => Card(
                    color: navigationController.selectedIndex.value == index ? Colors.lightBlue : AppColors.whiteColor,
                    child: InkWell(
                      onTap: () {
                        navigationController.selectedIndex.value = index;
                        FocusScope.of(context).requestFocus(navigationController.sideSelectionBoxFocusNodeList[index]);
                      },
                      hoverColor: AppColors.transparentColor,
                      highlightColor: AppColors.transparentColor,
                      focusColor: AppColors.transparentColor,
                      onFocusChange: (v) {
                        if (v) {
                          navigationController.selectedIndex.value = index;
                        }
                      },
                      autofocus: index == 0 ? true : false,
                      focusNode: navigationController.sideSelectionBoxFocusNodeList[index],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              navigationController.iconsList[index],
                              color: navigationController.selectedIndex.value == index
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                            ),
                            Text(
                              navigationController.titlesList[index],
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: navigationController.selectedIndex.value == index
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
