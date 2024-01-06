import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';

class CustomerTypeForm extends StatelessWidget {
  const CustomerTypeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value!.isEmpty || value.isNum || value.length < 4 ? 'Enter Category' : null,
                decoration: kTextFormFieldDecoration.copyWith(labelText: 'Customer Type'),
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
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.addButtonColor,
                        fixedSize: const Size(100, 50),
                      ),
                      child: const Text('Add', style: TextStyle(color: AppColors.addButtonTextColor))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
