// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class AppbarPart extends StatelessWidget {
  String name;
  AppbarPart({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors().mainColors,
      title: Text(
        name,
        style: TextStyle(fontSize: 22.sp),
      ),
      centerTitle: true,
    );
  }
}
