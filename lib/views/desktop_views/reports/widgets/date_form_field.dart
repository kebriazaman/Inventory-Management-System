import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/app_color.dart';

class DateFormField extends StatelessWidget {
  DateFormField(
      {required this.hintText,
      required this.onPress,
      required this.controller,
      required this.focusNode,
      super.key});

  String hintText;
  VoidCallback onPress;
  TextEditingController controller;
  FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.2,
      child: TextFormField(
        focusNode: focusNode,
        validator: (v) => !GetUtils.isDateTime(v!) ? 'Enter valid date format, yy-mm-dd' : null,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        controller: controller,
        onTap: onPress,
        decoration: InputDecoration(
          hoverColor: AppColors.transparentColor,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          suffixIcon: IconButton(onPressed: onPress, icon: const Icon(Icons.calendar_month)),
        ),
      ),
    );
  }
}
