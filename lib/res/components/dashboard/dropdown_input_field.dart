import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/views/desktop_views/products/widgets/category_form.dart';

class DropdownInputField extends StatelessWidget {
  DropdownInputField(
      {required this.initValue,
      required this.currentFocusNode,
      required this.nextFocusNode,
      required this.itemsList,
      required this.onValueChange,
      Key? key})
      : super(key: key);

  String initValue;
  FocusNode currentFocusNode;
  FocusNode nextFocusNode;
  List itemsList;
  void Function(String?) onValueChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField(
        value: initValue,
        focusNode: currentFocusNode,
        dropdownColor: AppColors.dropDownColor,
        decoration: kDropdownFormFieldDecoration.copyWith(
          prefixIcon: InkWell(
            onTap: () {
              Get.defaultDialog(
                title: 'Add Category',
                content: CategoryForm(),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        items: itemsList.map<DropdownMenuItem<String>>(
          (e) {
            return DropdownMenuItem(
              child: Text(e.name),
              value: e.name,
            );
          },
        ).toList(),
        onChanged: onValueChange,
      ),
    );
  }
}
