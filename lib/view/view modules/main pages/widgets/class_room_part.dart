// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';

class ClassRoomPart extends StatelessWidget {
  Icon icon;
  String service;
  ClassRoomPart({
    super.key,
    required this.icon,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: MyColors().mainColors,
            offset: const Offset(0, 0),
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
            spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(10.sp)),
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
            style: TextStyle(
              fontSize: 13.sp,
              color: MyColors().mainColors
            ),
          )
        ],
      ),
    );
  }
}
