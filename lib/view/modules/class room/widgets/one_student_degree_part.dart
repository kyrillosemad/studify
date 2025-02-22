// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class OneStudentDegreePart extends StatelessWidget {
  var state;
  OneStudentDegreePart({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (context, index) {
        var classData = state[index];
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: MyColors().mainColors,
                offset: const Offset(0, 0),
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(10.sp),
          ),
          margin: EdgeInsets.all(8.sp),
          child: ListTile(
            leading: Icon(
              Icons.class_,
              color: MyColors().mainColors,
            ),
            title: Text(
              classData['eventName'],
              style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
            ),
            trailing: Text(
              "Score: ${classData['studentScore'].toStringAsFixed(1)} / ${classData['totalScore'].toStringAsFixed(1)}",
              style: TextStyle(fontSize: 12.sp, color: MyColors().mainColors),
            ),
          ),
        );
      },
    );
  }
}
