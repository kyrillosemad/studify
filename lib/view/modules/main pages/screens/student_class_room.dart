// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/class_room/class_room_bloc.dart';
import 'package:studify/view/modules/main%20pages/widgets/class_room_class_date.dart';
import 'package:studify/view/modules/main%20pages/widgets/class_room_leave_class_button.dart';
import '../widgets/classroom_student_class_grid.dart';

class StudentClassRoom extends StatelessWidget {
  const StudentClassRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ClassRoomBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<ClassRoomBloc>();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors().mainColors,
                title: Text(controller.className),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Center(
                  child: SizedBox(
                    width: 97.w,
                    height: 95.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        ClassDate(date: controller.date),
                        SizedBox(height: 4.h),
                        ClassGrid(
                          controller: controller,
                        ),
                        SizedBox(height: 1.h),
                        ClassRoomLeaveClassButton(classId: controller.classId,controller: controller,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
