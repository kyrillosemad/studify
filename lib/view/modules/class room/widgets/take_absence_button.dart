import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';


class TakeAbsenceButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController eventNameCont;
  final TextEditingController totalScoreCont;
  final VoidCallback onConfirm;

  const TakeAbsenceButton({
    Key? key,
    required this.formKey,
    required this.eventNameCont,
    required this.totalScoreCont,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            title: "Take Absence",
            titleStyle: TextStyle(color: MyColors().mainColors),
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: eventNameCont,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.event),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Event name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  TextFormField(
                    controller: totalScoreCont,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.score),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Total Score",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the total score';
                      }
                      final int? score = int.tryParse(value);
                      if (score == null || score <= 0) {
                        return 'Total score must be a positive number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            onCancel: () {},
            onConfirm: onConfirm,
          );
        },
        child: Container(
          width: 90.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: MyColors().mainColors,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Center(
            child: Text(
              "Take Absence",
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
