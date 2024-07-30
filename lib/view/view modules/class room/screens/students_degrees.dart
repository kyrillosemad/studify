import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/styles.dart';
import 'package:studify/view/view%20modules/class%20room/screens/one_student_degree.dart';

class StudentsDegree extends StatefulWidget {
  const StudentsDegree({super.key});

  @override
  State<StudentsDegree> createState() => _StudentsDegreeState();
}

class _StudentsDegreeState extends State<StudentsDegree> {
  var classId = Get.arguments['classId'];
  TextEditingController searchCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ParticipantsBloc>().add(FetchParticipants(classId, ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: const Text("Students Degrees"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 95.w,
          height: 100.h,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "You can find here all students with all their degrees in different events",
                  style:
                      TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                controller: searchCont,
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: MyColors().mainColors,
                  ),
                  hintText: "Search By Name or ID",
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  ),
                ),
                onChanged: (value) {
                  context
                      .read<ParticipantsBloc>()
                      .add(FetchParticipants(classId, value));
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: BlocBuilder<ParticipantsBloc, ParticipantsState>(
                  builder: (context, state) {
                    if (state is ParticipantsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ParticipantsLoaded) {
                      if (state.participants.isEmpty) {
                        return Center(
                          child: Text(
                            "No participants found",
                            style: Styles().msgsStyles,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.participants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.to(const OneStudentDegree(), arguments: {
                                  "studentName": state.participants[index]
                                      ['studentName'],
                                  "studentId": state.participants[index]
                                      ['studentId'],
                                  "classId": classId,
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.sp),
                                decoration: BoxDecoration(
                                  color: MyColors().mainColors.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: ListTile(
                                  title: Text(
                                    state.participants[index]['studentName']
                                        .toString(),
                                  ),
                                  subtitle: Text(
                                    "ID: ${state.participants[index]['studentId'].toString()}",
                                  ),
                                  leading: const Icon(Icons.event),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is ParticipantsError) {
                      return Center(
                        child: Text(
                          "An error occurred: ${state.msg}",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
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
