import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/constants/styles.dart';
import 'package:studify/view%20model/degrees/degrees_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/one_student_degree_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class OneStudentDegree extends StatelessWidget {
  const OneStudentDegree({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DegreesBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<DegreesBloc>();
            controller.add(GetStudentDegrees(
                controller.classId, controller.studentId, ''));
            return Scaffold(
              appBar: AppBar(
                title: Text("${controller.studentName}"),
                centerTitle: true,
                backgroundColor: MyColors().mainColors,
              ),
              body: Center(
                child: SizedBox(
                  width: 95.w,
                  height: 100.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "There's all degrees of events of student ${controller.studentName}",
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SearchField(
                          hint: "Search",
                          onChanged: (value) {
                            controller.add(GetStudentDegrees(controller.classId,
                                controller.studentId, value.toString()));
                          },
                          type: TextInputType.text),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(
                        child: BlocBuilder<DegreesBloc, DegreesState>(
                          builder: (context, state) {
                            if (state is DegreesLoading) {
                              return  Center(
                                child: Lottie.asset(
              'assets/Animation - 1740512569959.json',
              height: 20.h,
              fit: BoxFit.contain,
            ),
                              );
                            } else if (state is DegreesError) {
                              return Center(
                                child: Text(
                                  "An error occurred: ${state.msg}",
                                  style: Styles().msgsStyles,
                                ),
                              );
                            } else if (state is DegreesLoaded) {
                              if (state.degrees.isEmpty) {
                                return Center(
                                  child:  Lottie.asset(
                'assets/Animation - 1740514545687.json',
                height: 28.h,
                fit: BoxFit.contain,
              )
                                );
                              } else {
                                double totalScore = state.degrees.fold(
                                    0.0,
                                    (previousValue, element) =>
                                        previousValue +
                                        element['studentScore']);
                                double highTotalScore = state.degrees.fold(
                                    0.0,
                                    (previousValue, element) =>
                                        previousValue + element['totalScore']);
                                return Column(
                                  children: [
                                    Expanded(
                                        child: OneStudentDegreePart(
                                            state: state.degrees)),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Total Score: ${totalScore.toStringAsFixed(1)} / ${highTotalScore.toStringAsFixed(1)}",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: MyColors().mainColors),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
