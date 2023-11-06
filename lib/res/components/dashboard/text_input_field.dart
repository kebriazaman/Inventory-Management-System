import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/utils.dart';

class TextInputField extends StatelessWidget {
  TextInputField({
    required this.myController,
    required this.currentFocusNode,
    required this.nextFocusNode,
    this.obscurePassword = false,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.textFormFieldDecoration,
    super.key,
  });

  final TextEditingController myController;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final Icon? suffixIcon;
  bool obscurePassword;
  final VoidCallback? onTap;
  String? Function(String?)? validator;
  InputDecoration? textFormFieldDecoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      obscureText: obscurePassword,
      controller: myController,
      focusNode: currentFocusNode,
      cursorColor: AppColors.blackColor,
      decoration: textFormFieldDecoration,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) => Utils.fieldFocusChange(context, currentFocusNode, nextFocusNode),
      validator: validator,
    );
  }
}
