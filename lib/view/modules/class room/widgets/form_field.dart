// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class FormFieldPart extends StatelessWidget {
  TextEditingController controller;
  var keyboardType;
  String hint;
  IconData icon;
  var validator;
  FormFieldPart(
      {super.key,
      required this.controller,
      required this.hint,
      required this.icon,
      required this.validator,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: MyColors().mainColors),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15.sp,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().mainColors),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().mainColors.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
      style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
      validator: validator,
    );
  }
}
