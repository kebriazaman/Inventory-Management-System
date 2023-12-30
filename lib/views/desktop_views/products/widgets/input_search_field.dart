import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';

class InputSearchField extends StatelessWidget {
  InputSearchField({
    required this.onTextChanged,
    super.key,
  });

  Function(String) onTextChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      height: 48,
      child: TextFormField(
        onChanged: onTextChanged,
        cursorColor: AppColors.blackColor,
        maxLines: 1,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search product by name',
          hintStyle: const TextStyle(color: AppColors.blackColor),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
