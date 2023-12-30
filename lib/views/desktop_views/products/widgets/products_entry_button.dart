import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/product_entry_form.dart';

class ProductsEntryButton extends StatelessWidget {
  const ProductsEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.find<ProductsController>();
    return ElevatedButton(
      onPressed: () {
        Get.defaultDialog(
          title: 'Add Product',
          content: const ProductsEntryForm(),
          actions: [
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
            Obx(
              () => ElevatedButton(
                focusNode: productsController.addButtonFocusNode,
                onPressed: productsController.isProductLoading.value
                    ? null
                    : () {
                        if (productsController.entryFormKey.currentState!.validate()) {
                          productsController.addProduct(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.addButtonColor,
                  fixedSize: const Size(100, 50),
                ),
                child: productsController.isProductLoading.value == false
                    ? const Text('Add', style: TextStyle(color: AppColors.addButtonTextColor))
                    : const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: CircularProgressIndicator(
                          color: AppColors.whiteColor,
                          strokeWidth: 2,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(150, 48),
      ),
      child: const Text(
        'Add Product',
        style: TextStyle(color: AppColors.buttonBackgroundColor),
      ),
    );
  }
}
