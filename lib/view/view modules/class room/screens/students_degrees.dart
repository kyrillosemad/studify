import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/get_all_participants.dart';
import 'package:studify/view/constants/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: const Text("Students Degree"),
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
                child: FutureBuilder(
                  future: getAllParticipants(classId.toString()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "An error occurred",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return Center(
                        child: Text(
                          "No participants found",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {},
                            child: InkWell(
                              onTap: () {
                                Get.to(const OneStudentDegree(), arguments: {
                                  "studentName": snapshot.data[index]
                                      ['studentName'],
                                  "studentId": snapshot.data[index]
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
                                  title: Text(snapshot.data[index]
                                          ['studentName']
                                      .toString()),
                                  subtitle: Text(
                                      "ID :${snapshot.data[index]['studentId'].toString()}"),
                                  leading: const Icon(Icons.event),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
