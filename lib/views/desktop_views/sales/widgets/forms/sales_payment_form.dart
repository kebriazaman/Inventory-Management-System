import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/action_button.dart';

class SalesPaymentForm extends StatelessWidget {
  const SalesPaymentForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SalesController salesController = Get.find<SalesController>();
    return Container(
      height: Get.height * 0.5,
      width: Get.width * 0.4,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('Payment Type')),
                  Expanded(
                    child: Obx(
                      () => DropdownButton<String>(
                        isExpanded: true,
                        menuMaxHeight: Get.height * 0.5,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(overflow: TextOverflow.ellipsis),
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        value: salesController.paymentType.value, // Initially selected value
                        onChanged: (String? newValue) {
                          salesController.setPaymentType(newValue.toString());
                        },
                        dropdownColor: AppColors.whiteColor,
                        items: <String>['Cash', 'Easypaisa ', 'Jazz Cash'] // List of dropdown items
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value), // Displayed dropdown item
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('Collected')),
                  Expanded(
                    child: TextFormField(
                      decoration: kSignupInputFieldDecoration.copyWith(
                        hintText: 'Collected Cash',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('Change')),
                  Expanded(
                    child: TextFormField(
                      decoration: kSignupInputFieldDecoration.copyWith(
                        hintText: 'Change Cash',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('Extra Discount')),
                  Expanded(
                    child: TextFormField(
                      decoration: kSignupInputFieldDecoration.copyWith(
                        hintText: 'Extra Discount',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ActionButton(
                    text: 'Cancel',
                    onPress: () {},
                    buttonStyle:
                        ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.redColor.withOpacity(0.9))),
                  ),
                  10.width,
                  ActionButton(
                    text: 'Submit',
                    onPress: () {},
                    buttonStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.appButtonColor.withOpacity(0.9))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
