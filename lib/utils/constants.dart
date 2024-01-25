import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

const kTextFormFieldDecoration = InputDecoration(
  labelText: 'Product Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: AppColors.blackColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.textFormFieldBorderColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: AppColors.textFormFieldBorderColor),
  ),
  contentPadding: EdgeInsets.all(16.0),
);

const kTextInputFieldDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.blackColor),
  ),
  hintText: 'Enter your email',
  hintStyle: TextStyle(fontSize: 14),
  contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
);

const kDropdownFormFieldDecoration = InputDecoration(
  hintText: 'Select Category',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: AppColors.primaryColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: AppColors.primaryColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: AppColors.primaryColor),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
);

const kAppbarTextFieldDecoration = InputDecoration(
  hintText: 'Search ',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
    borderSide: BorderSide(color: AppColors.blackColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
    borderSide: BorderSide(color: AppColors.textFormFieldBorderColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
    borderSide: BorderSide(color: AppColors.textFormFieldBorderColor),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
);
