import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';

class SignupWelcome extends StatelessWidget {
  const SignupWelcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome to Studify ",
          style: TextStyle(fontSize: 25.sp, color: MyColors().mainColors),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          "Create an new account now ",
          style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
        ),
      ],
    );
  }
}
