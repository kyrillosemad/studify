import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/shared_widgets/search_field.dart';
import 'package:studify/view%20model/class/bloc/class_bloc.dart';
import 'package:studify/view%20model/class/bloc/class_event.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_home_page.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/homepage_classes.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/homepage_texts.dart';

class StudentHomeBody extends StatelessWidget {
  final ClassBloc classBloc;
  final TextEditingController classIdController;
  final TextEditingController searchController;

  const StudentHomeBody({
    super.key,
    required this.classBloc,
    required this.classIdController,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Center(
            child: SizedBox(
              width: 95.w,
              height: 90.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  const GreetingText(),
                  SizedBox(height: 2.h),
                  const InstructionsText(),
                  SizedBox(height: 2.h),
                  const ClassesTitle(),
                  SizedBox(height: 2.h),
                  SearchField(
                      hint: "Search",
                      onChanged: (value) {
                        classBloc.add(GetClassForStudent(value));
                      },
                      type: TextInputType.text),
                  SizedBox(height: 2.h),
                  ClassList(classBloc: classBloc,Type: "student"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class AddClassButton extends StatelessWidget {
  final TextEditingController classIdController;

  const AddClassButton({
    super.key,
    required this.classIdController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: MyColors().mainColors,
          radius: 22.sp,
          child: IconButton(
            icon: Icon(
              Icons.add,
              size: 17.sp,
              color: Colors.white,
            ),
            onPressed: () {
              Get.defaultDialog(
                buttonColor: MyColors().mainColors,
                cancelTextColor: MyColors().mainColors,
                confirmTextColor: Colors.white,
                onCancel: () {},
                onConfirm: () {
                  context.read<ParticipantsBloc>().add(
                        AddParticipants(
                          classIdController.text,
                          Shared().id.toString(),
                          Shared().userName.toString(),
                        ),
                      );
                  classIdController.text = '';
                  Get.offAll(const StudentHomePage());
                },
                title: "Enroll in new class",
                titleStyle: TextStyle(color: MyColors().mainColors),
                content: SizedBox(
                  height: 6.h,
                  child: TextFormField(
                    controller: classIdController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.abc),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Class ID",
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



class LeaveClassButton extends StatelessWidget {
  final String classId;

  const LeaveClassButton({
    super.key,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          buttonColor: MyColors().mainColors,
          cancelTextColor: MyColors().mainColors,
          confirmTextColor: Colors.white,
          title: "Leave?",
          titleStyle: TextStyle(color: MyColors().mainColors),
          content: Text(
            "Want to leave this class?",
            style: TextStyle(color: MyColors().mainColors),
          ),
          onCancel: () {},
          onConfirm: () async {
            context.read<ParticipantsBloc>().add(
                  DeleteParticipants(
                    classId,
                    Shared().userName.toString(),
                    Shared().id.toString(),
                  ),
                );
            Get.offAll(const StudentHomePage());
          },
        );
      },
      child: Icon(
        Icons.logout_outlined,
        size: 25.sp,
        color: MyColors().mainColors,
      ),
    );
  }
}
