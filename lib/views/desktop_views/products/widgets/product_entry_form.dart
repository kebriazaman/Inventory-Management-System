import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/category_form.dart';

class ProductsEntryForm extends StatelessWidget {
  const ProductsEntryForm({super.key});
  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    return SizedBox(
      width: Get.width * 0.6,
      height: Get.height * 0.45,
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
                    child: TextFormField(
                      controller: productsController.nameController,
                      focusNode: productsController.nameFocusNode,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.text,
                      decoration: kTextFormFieldDecoration,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => GetUtils.isNull(value) || GetUtils.isLengthLessThan(value, 3)
                          ? 'Invalid name entered'
                          : null,
                      onFieldSubmitted: (v) => Utils.fieldFocusChange(
                          context, productsController.nameFocusNode, productsController.qtyFocusNode),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: DropdownSearch<CategoryModel>(
                        asyncItems: (String filter) async {
                          await productsController.fetchCategories();
                          return productsController.categoryList;
                        },
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                              autofocus: true, decoration: kTextInputFieldDecoration.copyWith(hintText: 'Search')),
                          showSearchBox: true,
                        ),
                        filterFn: (category, filter) =>
                            category.name!.toLowerCase().contains(filter.toLowerCase()),
                        clearButtonProps: const ClearButtonProps(
                            color: AppColors.blackColor, isVisible: true, icon: Icon(Icons.clear, size: 16.0)),
                        itemAsString: (category) => category.name.toString(),
                        dropdownBuilder: (context, selectedItem) {
                          return Text(selectedItem?.name ?? 'Search',
                              style: const TextStyle(color: AppColors.blueColor));
                        },
                        validator: (item) =>
                            GetUtils.isNull(item?.name) || item?.name == 'Select' ? 'Invalid item selected' : null,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (CategoryModel? category) {
                          productsController.setFormCategory(category!.name.toString());
                          Utils.fieldFocusChange(
                              context, productsController.categoryFocusNode, productsController.qtyFocusNode);
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: kDropdownFormFieldDecoration.copyWith(
                          prefixIcon: IconButton(
                              onPressed: () =>
                                  Get.defaultDialog(title: 'Add Category', content: const CategoryForm()),
                              icon: const Icon(Icons.add)),
                        ))),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      controller: productsController.qtyController,
                      focusNode: productsController.qtyFocusNode,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Quantity'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          GetUtils.isLengthLessOrEqual(value, 0) || GetUtils.isAlphabetOnly(value!)
                              ? 'Enter the numeric value'
                              : null,
                      onFieldSubmitted: (v) => Utils.fieldFocusChange(
                          context, productsController.qtyFocusNode, productsController.purchasePriceFocusNode),
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: productsController.purchasePriceController,
                      focusNode: productsController.purchasePriceFocusNode,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Purchase Price'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => GetUtils.isLengthLessOrEqual(value, 0) || !GetUtils.isNum(value!)
                          ? 'Enter the numeric value'
                          : null,
                      onFieldSubmitted: (v) => Utils.fieldFocusChange(context,
                          productsController.purchasePriceFocusNode, productsController.salePriceFocusNode),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      controller: productsController.salePriceController,
                      focusNode: productsController.salePriceFocusNode,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Sale Price'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => ProductsModel.isSalePriceValid(
                        productsController.purchasePriceController.text.trim(),
                        productsController.salePriceController.text.trim(),
                      ),
                      onFieldSubmitted: (v) => Utils.fieldFocusChange(
                          context, productsController.salePriceFocusNode, productsController.discountFocusNode),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      controller: productsController.discountController,
                      focusNode: productsController.discountFocusNode,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Discount %'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => GetUtils.isAlphabetOnly(value!) ? 'Enter valid discount %' : null,
                      onFieldSubmitted: (v) => Utils.fieldFocusChange(
                          context, productsController.discountFocusNode, productsController.manufacturerFocusNode),
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: productsController.manufacturerController,
                      focusNode: productsController.manufacturerFocusNode,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Manufacturer'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          GetUtils.isNull(value) || GetUtils.isNull(value) || GetUtils.isLengthLessThan(value, 3)
                              ? 'Invalid name entered'
                              : null,
                      onFieldSubmitted: (v) => Utils.fieldFocusChange(context,
                          productsController.manufacturerFocusNode, productsController.addButtonFocusNode),
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
