import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/products/productsController.dart';
import 'package:pos_fyp/controllers/navigation_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/utils.dart';

class FilterProductsDropdown extends StatelessWidget {
  const FilterProductsDropdown({super.key});
  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.find<ProductsController>();
    final NavigationController navigationController = Get.find<NavigationController>();
    return Container(
      width: Get.width * 0.1,
      height: Get.height * 0.06,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: DropdownButton(
        isExpanded: true,
        menuMaxHeight: Get.height * 0.5,
        focusNode: productsController.dropdownBtnFocusNode,
        focusColor: AppColors.transparentColor,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(overflow: TextOverflow.ellipsis),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        value: productsController.categorySelectedValue.value,
        items: productsController.categoryList
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(
                value: e.name,
                child: Text(e.name.toString()),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            productsController.setCategory(value.toString());
            productsController.filterProductsByCategory(value);
          }
          Utils.fieldFocusChange(
              context, productsController.dropdownBtnFocusNode, navigationController.screenSelectionNode_2);
        },
      ),
    );
  }
}
