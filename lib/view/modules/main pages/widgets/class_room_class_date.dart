import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class ClassDate extends StatelessWidget {
  const ClassDate({Key? key, required this.date}) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Text(
      "date : $date",
      style: TextStyle(fontSize: 17.sp, color: MyColors().mainColors),
    );
  }
}