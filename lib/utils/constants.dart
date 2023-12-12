import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

const kTextFormFieldDecoration = InputDecoration(
  labelText: 'Product Code',
  labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
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

const kLoginInputFieldDecoration = InputDecoration(
  focusColor: AppColors.blackColor,
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.blackColor),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 4),
  labelText: 'Enter your email or user name',
  labelStyle: TextStyle(color: AppColors.blackColor, fontSize: 14),
);

const kSignupInputFieldDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.blackColor),
  ),
  hintText: 'Enter your email',
  hintStyle: TextStyle(fontSize: 13),
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
);
