import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/custom_progress_indicator.dart';
import 'package:pos_fyp/utils/constants.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});
  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    return SizedBox(
      width: Get.width * 0.3,
      child: Form(
        key: productsController.categoryFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: productsController.categoryController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value!.isEmpty || value.isNum || value.length < 4 ? 'Enter Category' : null,
                decoration: kTextFormFieldDecoration.copyWith(labelText: 'Category'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cancelButtonColor,
                      fixedSize: const Size(100, 50),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.cancelButtonTextColor),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => ElevatedButton(
                        focusNode: productsController.addCatBtnFocusNode,
                        onPressed: productsController.isCategoryLoading.value
                            ? null
                            : () {
                                if (productsController.categoryFormKey.currentState!.validate()) {
                                  productsController.addCategory(context);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.addButtonColor,
                          fixedSize: const Size(100, 50),
                        ),
                        child: productsController.isCategoryLoading.value
                            ? CustomProgressIndicator(width: 20, height: 20, color: AppColors.whiteColor)
                            : const Text('Add', style: TextStyle(color: AppColors.addButtonTextColor))),
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
