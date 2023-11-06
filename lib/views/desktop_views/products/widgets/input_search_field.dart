import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';

class InputSearchField extends StatelessWidget {
  InputSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        maxLines: 1,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search',
          hintStyle: const TextStyle(color: AppColors.blackColor),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blackColor,
          ),
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
