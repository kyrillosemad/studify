import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/degrees/bloc/degrees_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/styles.dart';

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

  void _onSearchChanged() {
    context
        .read<DegreesBloc>()
        .add(GetStudentDegrees(classId, studentId, searchCont.text));
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
              TextFormField(
                controller: searchCont,
                onChanged: (value) => _onSearchChanged(),
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyColors().mainColors,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.sp)))),
              ),
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
                              child: ListView.builder(
                                itemCount: state.degrees.length,
                                itemBuilder: (context, index) {
                                  var classData = state.degrees[index];
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
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                                    margin: EdgeInsets.all(8.sp),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.class_,
                                        color: MyColors().mainColors,
                                      ),
                                      title: Text(
                                        classData['eventName'],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: MyColors().mainColors),
                                      ),
                                      trailing: Text(
                                        "Score: ${classData['studentScore'].toStringAsFixed(1)} / ${classData['totalScore'].toStringAsFixed(1)}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: MyColors().mainColors),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
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
