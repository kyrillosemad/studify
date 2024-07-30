
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello,  ${Shared().userName}",
      style: TextStyle(
        fontSize: 15.sp,
        color: MyColors().mainColors,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class InstructionsText extends StatelessWidget {
  const InstructionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "you can here view your class rooms and create new one",
      style: TextStyle(
        fontSize: 12.sp,
        color: MyColors().mainColors,
      ),
    );
  }
}

class ClassesTitle extends StatelessWidget {
  const ClassesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your class rooms",
      style: TextStyle(
        fontSize: 15.sp,
        color: MyColors().mainColors,
      ),
    );
  }
}