import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/class_room/class_room_bloc.dart';
import 'package:studify/view/modules/main%20pages/widgets/class_room_part.dart';
import '../widgets/class_room_class_date.dart';

class DoctorClassRoom extends StatelessWidget {
  const DoctorClassRoom({super.key});

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
                        Text(
                          "ClassID : ${controller.classId}",
                          style: TextStyle(
                              fontSize: 17.sp, color: MyColors().mainColors),
                        ),
                        SizedBox(height: 2.h),
                        ClassDate(date: controller.date),
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
                                itemCount: controller.services.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final service = controller.services[index];
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
                                titleStyle:
                                    TextStyle(color: MyColors().mainColors),
                                content: Text(
                                  "Do you want to delete this class?",
                                  style:
                                      TextStyle(color: MyColors().mainColors),
                                ),
                                onCancel: () {},
                                onConfirm: () {
                                  controller.add(DeleteClassForDoctorEvent());
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
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.white),
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
          },
        ));
  }
}
