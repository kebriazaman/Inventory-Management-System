import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/components/dashboard/text_input_field.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/category_form.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/discount_form.dart';

class ProductsEntryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    return SizedBox(
      width: Get.width * 0.6,
      height: Get.height * 0.6,
      child: Form(
        key: productsController.entryFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      myController: productsController.productNameController,
                      currentFocusNode: productsController.nameFocusNode,
                      nextFocusNode: productsController.categoryFocusNode,
                      validator: (value) => GetUtils.isNull(value) || GetUtils.isLengthLessOrEqual(value, 3)
                          ? 'Invalid name entered'
                          : null,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Product Name'),
                    ),
                  ),
                  10.width,
                  Obx(
                    () => Expanded(
                      child: DropdownButtonFormField(
                        value: productsController.catInitValue.value,
                        focusNode: productsController.categoryFocusNode,
                        dropdownColor: AppColors.dropDownColor,
                        validator: (v) => v == 'Select' || v == null ? 'Invalid item selected' : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: kDropdownFormFieldDecoration.copyWith(
                          prefixIcon: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Add Category',
                                content: const CategoryForm(),
                              );
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                        items: productsController.categoryList.map<DropdownMenuItem<String>>(
                          (e) {
                            return DropdownMenuItem(
                              child: Text(e.name),
                              value: e.name,
                            );
                          },
                        ).toList(),
                        onChanged: (v) {
                          productsController.setCategory = v.toString();
                          Utils.fieldFocusChange(
                              context, productsController.categoryFocusNode, productsController.qtyFocusNode);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      myController: productsController.productQuantityController,
                      currentFocusNode: productsController.qtyFocusNode,
                      nextFocusNode: productsController.purchasePriceFocusNode,
                      validator: (value) => GetUtils.isLengthLessOrEqual(value, 0) || GetUtils.isAlphabetOnly(value!)
                          ? 'Enter the numeric value'
                          : null,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextInputField(
                      myController: productsController.productPurchasePriceController,
                      currentFocusNode: productsController.purchasePriceFocusNode,
                      nextFocusNode: productsController.salePriceFocusNode,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Purchase Price'),
                      validator: (value) => GetUtils.isLengthLessOrEqual(value, 0) || GetUtils.isAlphabetOnly(value!)
                          ? 'Enter the numeric value'
                          : null,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextInputField(
                      myController: productsController.productSalePriceController,
                      currentFocusNode: productsController.salePriceFocusNode,
                      nextFocusNode: productsController.discountFocusNode,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Sale Price'),
                      validator: (value) => GetUtils.isLengthLessOrEqual(value, 0) || GetUtils.isAlphabetOnly(value!)
                          ? 'Enter numeric value'
                          : null,
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: DropdownButtonFormField(
                        value: productsController.discInitValue.value,
                        focusNode: productsController.discountFocusNode,
                        dropdownColor: AppColors.dropDownColor,
                        validator: (v) => v == 'Select' || v == null ? 'Invalid item selected' : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: kDropdownFormFieldDecoration.copyWith(
                          prefixIcon: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Add Category',
                                content: const DiscountForm(),
                              );
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                        items: productsController.discountList.map<DropdownMenuItem<String>>(
                          (e) {
                            return DropdownMenuItem(
                              value: e.discountPer,
                              child: Text(e.discountPer),
                            );
                          },
                        ).toList(),
                        onChanged: (v) {
                          productsController.setDiscount = v.toString();
                          Utils.fieldFocusChange(
                              context, productsController.discountFocusNode, productsController.gstFocusNode);
                        },
                      ),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextInputField(
                      myController: productsController.productGSTPerController,
                      currentFocusNode: productsController.gstFocusNode,
                      nextFocusNode: productsController.manufacturerFocusNode,
                      validator: (value) => GetUtils.isLengthLessOrEqual(value, 0) || GetUtils.isAlphabetOnly(value!)
                          ? 'Enter the numeric value'
                          : null,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Gst %'),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextInputField(
                      myController: productsController.productManufacturerController,
                      currentFocusNode: productsController.manufacturerFocusNode,
                      nextFocusNode: productsController.addButtonFocusNode,
                      validator: (value) => GetUtils.isNum(value!) || !GetUtils.isLengthGreaterOrEqual(value, 4)
                          ? 'Invalid name entered'
                          : null,
                      textFormFieldDecoration: kTextFormFieldDecoration.copyWith(labelText: 'Manufacturer'),
                    ),
                  ),
                ],
              ),
              20.height,
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
                      focusNode: productsController.addButtonFocusNode,
                      onPressed: productsController.isProductLoading.value == false
                          ? () {
                              if (productsController.entryFormKey.currentState!.validate()) {
                                productsController.addProduct(context);
                              }
                            }
                          : null,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
