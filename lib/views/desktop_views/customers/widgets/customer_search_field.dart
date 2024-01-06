import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';

class CustomerSearchField extends StatelessWidget {
  const CustomerSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      height: 40,
      child: TextFormField(
        decoration: kLoginInputFieldDecoration.copyWith(
          prefixIcon: Icon(Icons.search, color: AppColors.blackColor.withOpacity(0.3), size: 20),
          hintText: 'Search Customer',
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.blackColor),
        ),
      ),
    );
  }
}
