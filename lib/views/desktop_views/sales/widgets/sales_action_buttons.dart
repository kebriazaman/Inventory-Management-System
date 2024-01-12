import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/action_button.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/forms/sales_payment_form.dart';

class SalesActionButtons extends StatelessWidget {
  const SalesActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.put(CustomerController());
    final SalesController salesController = Get.find<SalesController>();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionButton(
            text: 'Cancel',
            onPress: () {
              salesController.clearData();
            },
            buttonStyle: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.redColor.withOpacity(0.9))),
          ),
          5.width,
          ActionButton(
            text: 'Proceed',
            onPress: () {
              if (salesController.selectedProducts.isNotEmpty &&
                  customerController.customerEditingController.text.isNotEmpty) {
                Get.defaultDialog(
                  title: 'Payment',
                  backgroundColor: AppColors.whiteColor,
                  content: const SalesPaymentForm(),
                );
              } else {
                Utils.showDialogueMessage('Error', 'Either customer or item is not selected', Icons.error_outline);
              }
            },
            buttonStyle:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.appButtonColor.withOpacity(0.9))),
          ),
        ],
      ),
    );
  }
}
