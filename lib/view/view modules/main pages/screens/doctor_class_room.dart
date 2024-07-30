import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/class/bloc/class_bloc.dart';
import 'package:studify/view%20model/class/bloc/class_event.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/add_another_event.dart';
import 'package:studify/view/view%20modules/class%20room/screens/chat_page.dart';
import 'package:studify/view/view%20modules/class%20room/screens/data_for_doctor.dart';
import 'package:studify/view/view%20modules/class%20room/screens/make_quiz.dart';
import 'package:studify/view/view%20modules/class%20room/screens/my_events.dart';
import 'package:studify/view/view%20modules/class%20room/screens/participants.dart';
import 'package:studify/view/view%20modules/class%20room/screens/students_degrees.dart';
import 'package:studify/view/view%20modules/class%20room/screens/take_absence.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/class_room_class_date.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/class_room_part.dart';

class DoctorClassRoom extends StatelessWidget {
  const DoctorClassRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final classId = Get.arguments['classId'];
    final className = Get.arguments['className'];
    final date = Get.arguments['date'];

    final services = [
      _Service(
        onTap: () =>
            Get.to(const Participants(), arguments: {"classId": classId}),
        color: Colors.green,
        icon: Icons.group,
        service: "Participants",
      ),
      _Service(
        onTap: () => Get.to(const MyEvents(), arguments: {"classId": classId}),
        color: Colors.amber,
        icon: Icons.event,
        service: "My events",
      ),
      _Service(
        onTap: () =>
            Get.to(const TakeAbsence(), arguments: {"classId": classId}),
        color: Colors.grey,
        icon: Icons.person_add_alt_1_outlined,
        service: "Take Absence",
      ),
      _Service(
        onTap: () =>
            Get.to(const StudentsDegree(), arguments: {"classId": classId}),
        color: Colors.indigoAccent,
        icon: Icons.stacked_bar_chart,
        service: "Students degrees",
      ),
      _Service(
        onTap: () =>
            Get.to(const AddAnotherEvent(), arguments: {"classId": classId}),
        color: Colors.blueAccent,
        icon: Icons.add,
        service: "Add other events",
      ),
      _Service(
        onTap: () => Get.to(const ChatPage(), arguments: {"classId": classId}),
        color: Colors.orange,
        icon: Icons.chat,
        service: "Chat Room",
      ),
      _Service(
        onTap: () => Get.to(const MakeQuiz(), arguments: {"classId": classId}),
        color: Colors.redAccent,
        icon: Icons.quiz,
        service: "Quiz",
      ),
      _Service(
        onTap: () =>
            Get.to(const DataForDoctor(), arguments: {"classId": classId}),
        color: Colors.tealAccent,
        icon: Icons.menu_book_sharp,
        service: "Data",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: Text(className),
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
                Text(
                  "ClassID : $classId",
                  style:
                      TextStyle(fontSize: 17.sp, color: MyColors().mainColors),
                ),
                SizedBox(height: 2.h),
                ClassDate(date: date),
                SizedBox(height: 3.h),
                Center(
                  child: SizedBox(
                    width: 95.w,
                    height: 67.h,
                    child: Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: services.length,
                        itemBuilder: (BuildContext context, int index) {
                          final service = services[index];
                          return InkWell(
                            onTap: service.onTap,
                            child: ClassRoomPart(
                              color: service.color,
                              icon: Icon(service.icon,
                                  color: MyColors().mainColors),
                              service: service.service,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        buttonColor: MyColors().mainColors,
                        cancelTextColor: MyColors().mainColors,
                        confirmTextColor: Colors.white,
                        title: "Delete?",
                        titleStyle: TextStyle(color: MyColors().mainColors),
                        content: Text(
                          "Do you want to delete this class?",
                          style: TextStyle(color: MyColors().mainColors),
                        ),
                        onCancel: () {},
                        onConfirm: () {
                          context
                              .read<ClassBloc>()
                              .add(DeleteClassForDoctor(classId));
                          Get.offAll(const DoctorHomePage());
                        },
                      );
                    },
                    child: Container(
                      width: 90.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Center(
                        child: Text(
                          "Delete this class",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Service {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  final String service;

  _Service({
    required this.onTap,
    required this.color,
    required this.icon,
    required this.service,
  });
}
