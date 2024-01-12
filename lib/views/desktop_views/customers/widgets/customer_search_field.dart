import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/debouncer.dart';

import '../../../../utils/utils.dart';

class CustomerSearchField extends StatelessWidget {
  const CustomerSearchField({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.find<CustomerController>();
    return SizedBox(
      width: Get.width * 0.3,
      height: 40,
      child: TextFormField(
        decoration: kLoginInputFieldDecoration.copyWith(
          prefixIcon: Icon(Icons.search, color: AppColors.blackColor.withOpacity(0.3), size: 20),
          hintText: 'Search Customer',
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.blackColor),
        ),
        onChanged: (v) {
          Debouncer(millisecs: 800).run(() {
            customerController.filterCustomerByName(v);
          });
        },
      ),
    );
  }
}
