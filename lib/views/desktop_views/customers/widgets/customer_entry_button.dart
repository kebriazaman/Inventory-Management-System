import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/views/desktop_views/customers/widgets/customer_form.dart';

class CustomerEntryButton extends StatelessWidget {
  const CustomerEntryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Get.defaultDialog(
          title: 'New customer',
          titleStyle: const TextStyle(fontWeight: FontWeight.w500),
          content: const CustomerForm(),
        );
      },
      icon: const Icon(Icons.add, color: AppColors.whiteColor, size: 20.0),
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(150, 48),
      ),
      label: const Text(
        'Customer',
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
