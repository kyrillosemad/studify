import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class WelcomeTextSection extends StatelessWidget {
  const WelcomeTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome Back ",
          style: TextStyle(fontSize: 25.sp, color: MyColors().mainColors),
        ),
        SizedBox(height: 2.h),
        Text(
          "login to your account",
          style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
        ),
      ],
    );
  }
}
