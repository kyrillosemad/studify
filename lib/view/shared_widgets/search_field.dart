// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class SearchField extends StatelessWidget {
  String hint;
  var onChanged;
  var type;
  SearchField({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      style: TextStyle(color: MyColors().mainColors, fontSize: 13.sp),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: MyColors().mainColors,
          size: 20.sp,
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
