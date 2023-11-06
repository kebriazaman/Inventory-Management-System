import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/utils.dart';

class TextInputField extends StatelessWidget {
  TextInputField({
    required this.myController,
    required this.myFocusNode,
    required this.nextFocusNode,
    required this.labelText,
    this.obscurePassword = false,
    this.suffixIcon,
    this.onTap,
    this.validator,
    super.key,
  });

  final String labelText;
  final TextEditingController myController;
  final FocusNode myFocusNode;
  final FocusNode nextFocusNode;
  final Icon? suffixIcon;
  bool obscurePassword;

  final VoidCallback? onTap;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscurePassword,
      controller: myController,
      focusNode: myFocusNode,
      cursorColor: AppColors.blackColor,
      decoration: kTextFormFieldDecoration.copyWith(
        labelText: labelText,
        hintStyle: const TextStyle(fontSize: 14),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Container(child: suffixIcon),
          color: AppColors.blackColor,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) => Utils.fieldFocusChange(context, myFocusNode, nextFocusNode),
      validator: validator,
    );
  }
}
