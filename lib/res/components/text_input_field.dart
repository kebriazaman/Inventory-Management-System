import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class TextInputField extends StatelessWidget {
  TextInputField({
    required this.myController,
    required this.currentFocusNode,
    required this.nextFocusNode,
    required this.keyboardType,
    this.obscurePassword = false,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.textFormFieldDecoration,
    required this.onSubmit,
    this.onChange,
    super.key,
  });

  final TextEditingController myController;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final Icon? suffixIcon;
  bool obscurePassword;
  final VoidCallback? onTap;
  final Function(String v) onSubmit;
  final Function(String? v)? onChange;
  String? Function(String?)? validator;
  InputDecoration? textFormFieldDecoration;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      obscureText: obscurePassword,
      controller: myController,
      focusNode: currentFocusNode,
      keyboardType: keyboardType,
      cursorColor: AppColors.blackColor,
      decoration: textFormFieldDecoration,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );
  }
}
