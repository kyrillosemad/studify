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
            title: "Take Absence",
            titleStyle: TextStyle(
              color: MyColors().mainColors,
              fontSize: 16.sp, // حجم خط متجاوب
              fontWeight: FontWeight.bold,
            ),
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            radius: 12.sp, // زوايا ناعمة للحواف
            content: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w, vertical: 2.h), // تحسين التباعد
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // تجنب التمدد غير الضروري
                  children: [
                    TextFormField(
                      controller: eventNameCont,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.event, size: 18.sp),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: MyColors().mainColors),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        hintText: "Event name",
                      ),
                      style: TextStyle(fontSize: 14.sp),
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.score, size: 18.sp),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: MyColors().mainColors),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        hintText: "Total Score",
                      ),
                      style: TextStyle(fontSize: 14.sp),
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
