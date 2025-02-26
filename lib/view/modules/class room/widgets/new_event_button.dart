// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/form_field.dart';

class NewEventButton extends StatefulWidget {
  var classId;
  var eventId;
  var formKey;
  TextEditingController eventNameCont;
  TextEditingController totalScoreCont;
  String name;
  NewEventButton(
      {super.key,
      required this.classId,
      required this.name,
      this.eventId,
      required this.eventNameCont,
      required this.formKey,
      required this.totalScoreCont});

  @override
  State<NewEventButton> createState() => _NewEventButtonState();
}

class _NewEventButtonState extends State<NewEventButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          buttonColor: MyColors().mainColors,
          cancelTextColor: MyColors().mainColors,
          confirmTextColor: Colors.white,
          title: widget.name,
          titleStyle: TextStyle(color: MyColors().mainColors),
          content: Form(
            key: widget.formKey,
            child: Column(
              children: [
                FormFieldPart(
                    controller: widget.eventNameCont,
                    hint: "Event Name",
                    icon: Icons.date_range,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Name cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text),
                SizedBox(height: 2.h),
                FormFieldPart(
                    controller: widget.totalScoreCont,
                    hint: "Total Score",
                    icon: Icons.score,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Total Score cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number)
              ],
            ),
          ),
          onCancel: () {},
          onConfirm: () {
            if (widget.formKey.currentState?.validate() ?? false) {
              setState(() {
                context.read<EventsBloc>().add(AddEvent(
                    widget.classId.toString(),
                    widget.eventNameCont.text,
                    widget.eventId.toString(),
                    widget.totalScoreCont.text, []));
                Get.back();
              });
            }
          },
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
            widget.name,
            style: TextStyle(fontSize: 13.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
