import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/text_input_field.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';

class DiscountForm extends StatelessWidget {
  const DiscountForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    return SizedBox(
      width: Get.width * 0.3,
      child: Form(
        key: productsController.discountFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInputField(
                myController: productsController.productDiscountController,
                currentFocusNode: productsController.discountFocusNode,
                nextFocusNode: productsController.addDiscBtnFocusNode,
                textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Enter discount %'),
                validator: (value) {
                  if (productsController.productSalePriceController.text.isEmpty) {
                    return 'Enter sale price first';
                  } else if (RegExp(r"^[^%]*$").hasMatch(value!)) {
                    return 'Enter the value in percentage';
                  } else {
                    return null;
                  }
                },
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    focusNode: productsController.addDiscBtnFocusNode,
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cancelButtonColor, fixedSize: const Size(100, 50)),
                    child: const Text('Cancel', style: TextStyle(color: AppColors.cancelButtonTextColor)),
                  ),
                  10.width,
                  Obx(
                    () => productsController.isDiscountLoading.value == true
                        ? const Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (productsController.discountFormKey.currentState!.validate()) {
                                productsController.addDiscount();
                                productsController.getDiscountList();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.addButtonColor, fixedSize: const Size(100, 50)),
                            child: const Text('Add', style: TextStyle(color: AppColors.addButtonTextColor)),
                          ),
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
