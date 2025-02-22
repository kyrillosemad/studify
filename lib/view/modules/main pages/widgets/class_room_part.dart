// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class ClassRoomPart extends StatelessWidget {
  Icon icon;
  String service;
  Color color;
  ClassRoomPart({
    super.key,
    required this.icon,
    required this.service,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.sp)),
      margin: EdgeInsets.all(5.sp),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          icon,
          SizedBox(
            height: 4.h,
          ),
          Text(
            service,
            style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
          )
        ],
      ),
    );
  }
}


