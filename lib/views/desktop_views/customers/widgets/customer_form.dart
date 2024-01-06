import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/views/desktop_views/customers/widgets/customer_type_form.dart';

class CustomerForm extends StatelessWidget {
  const CustomerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.5,
      height: Get.height * 0.4,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.text,
                      decoration: kTextFormFieldDecoration.copyWith(
                          labelText: 'Name', labelStyle: Theme.of(context).textTheme.bodySmall),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.isEmpty || GetUtils.isLengthLessThan(value, 3) ? 'Invalid name entered' : null,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: DropdownSearch<CategoryModel>(
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                              autofocus: true,
                              decoration: kLoginInputFieldDecoration.copyWith(
                                hintText: 'Search customer',
                                hintStyle: Theme.of(context).textTheme.bodySmall,
                              )),
                          showSearchBox: true,
                        ),
                        filterFn: (category, filter) => category.name!.toLowerCase().contains(filter.toLowerCase()),
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
                        onChanged: (CategoryModel? category) {},
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: kDropdownFormFieldDecoration.copyWith(
                          prefixIcon: IconButton(
                            onPressed: () => Get.defaultDialog(
                              title: 'Add Customer Type',
                              titleStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                              content: const CustomerTypeForm(),
                            ),
                            icon: const Icon(Icons.add),
                          ),
                        ))),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Phone Number'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => GetUtils.isLengthLessOrEqual(value, 0) || !GetUtils.isNum(value.toString())
                          ? 'Enter the numeric value'
                          : null,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Email Address'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => !GetUtils.isEmail(value.toString()) ? 'Enter valid email address' : null,
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.text,
                      decoration: kTextFormFieldDecoration.copyWith(
                          labelText: 'City', labelStyle: Theme.of(context).textTheme.bodySmall),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.isEmpty || GetUtils.isLengthLessThan(value, 3) ? 'Invalid name entered' : null,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.text,
                      decoration: kTextFormFieldDecoration.copyWith(
                          labelText: 'Address', labelStyle: Theme.of(context).textTheme.bodySmall),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.isEmpty || GetUtils.isLengthLessThan(value, 3) ? 'Invalid name entered' : null,
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.cancelButtonTextColor),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.cancelButtonColor,
                      minimumSize: const Size(120, 40),
                    ),
                  ),
                  10.width,
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.addButtonColor,
                      minimumSize: const Size(120, 40),
                    ),
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.addButtonTextColor),
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
