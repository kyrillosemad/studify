import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/constants/styles.dart';
import 'package:studify/view%20model/degrees/degrees_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/one_student_degree_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class OneStudentDegree extends StatefulWidget {
  const OneStudentDegree({super.key});

  @override
  State<OneStudentDegree> createState() => _OneStudentDegreeState();
}

class _OneStudentDegreeState extends State<OneStudentDegree> {
  var studentName = Get.arguments['studentName'];
  var studentId = Get.arguments['studentId'];
  var classId = Get.arguments['classId'];
  TextEditingController searchCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DegreesBloc>().add(GetStudentDegrees(classId, studentId, ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$studentName"),
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
                "There's all degrees of events of student $studentName",
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
              ),
              SizedBox(
                height: 2.h,
              ),
              SearchField(
                  hint: "Search",
                  onChanged: (value) => context
                      .read<DegreesBloc>()
                      .add(GetStudentDegrees(classId, studentId, value)),
                  type: TextInputType.text),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: BlocBuilder<DegreesBloc, DegreesState>(
                  builder: (context, state) {
                    if (state is DegreesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
                          child: Text(
                            "No events found",
                            style: Styles().msgsStyles,
                          ),
                        );
                      } else {
                        double totalScore = state.degrees.fold(
                            0.0,
                            (previousValue, element) =>
                                previousValue + element['studentScore']);
                        double highTotalScore = state.degrees.fold(
                            0.0,
                            (previousValue, element) =>
                                previousValue + element['totalScore']);
                        return Column(
                          children: [
                            Expanded(
                                child:
                                    OneStudentDegreePart(state: state.degrees)),
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
  }
}
