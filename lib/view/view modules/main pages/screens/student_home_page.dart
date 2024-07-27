import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/logout_fun.dart';
import 'package:studify/services/firebase/class/get_my_classes_for_students.dart';
import 'package:studify/services/firebase/participants/add_participants.dart';
import 'package:studify/services/firebase/participants/delete_participant.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_class_room.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  TextEditingController classId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  buttonColor: MyColors().mainColors,
                  cancelTextColor: MyColors().mainColors,
                  confirmTextColor: Colors.white,
                  title: "Logout",
                  titleStyle: TextStyle(color: MyColors().mainColors),
                  content: Text(
                    "Do you really want to log out?",
                    style: TextStyle(color: MyColors().mainColors),
                  ),
                  onCancel: () {},
                  onConfirm: () {
                    logOutFun();
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.all(4.sp),
                child: const Icon(Icons.logout),
              ),
            )
          ],
          title: const Text(
            "Studify",
          ),
          backgroundColor: MyColors().mainColors,
        ),
        body: SingleChildScrollView(
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
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Hello,  ${Shared().userName}",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: MyColors().mainColors,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "you can here view your class rooms and create new one ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: MyColors().mainColors,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Your class rooms ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: MyColors().mainColors,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 6.h,
                      child: TextFormField(
                          style: TextStyle(
                              color: MyColors().mainColors, fontSize: 13.sp),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: MyColors().mainColors,
                              ),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: MyColors().mainColors,
                                  fontSize: 13.sp),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sp))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.sp))))),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    FutureBuilder(
                      future: getMyClassesForStudents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Expanded(
                              child: Center(
                            child: CircularProgressIndicator(),
                          ));
                        } else if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                "there's no classes now",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: MyColors().mainColors),
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(const StudentClassRoom(),
                                        arguments: {
                                          "date": snapshot.data![index]['date'],
                                          "classId": snapshot.data![index]
                                              ['id'],
                                          "className": snapshot.data![index]
                                              ['name']
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: MyColors().mainColors,
                                            offset: const Offset(0, 0),
                                            blurRadius: 5,
                                            blurStyle: BlurStyle.outer,
                                            spreadRadius: 1)
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        10.sp,
                                      ),
                                    ),
                                    height: 12.h,
                                    margin: EdgeInsets.all(5.sp),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.class_,
                                        color: MyColors().mainColors,
                                      ),
                                      title: Text(
                                        "${snapshot.data![index]['name']}",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: MyColors().mainColors),
                                      ),
                                      trailing: InkWell(
                                        onTap: () async {
                                          Get.defaultDialog(
                                            buttonColor: MyColors().mainColors,
                                            cancelTextColor:
                                                MyColors().mainColors,
                                            confirmTextColor: Colors.white,
                                            title: "leave ?",
                                            titleStyle: TextStyle(
                                                color: MyColors().mainColors),
                                            content: Text(
                                              "want to leave this class?",
                                              style: TextStyle(
                                                  color: MyColors().mainColors),
                                            ),
                                            onCancel: () {},
                                            onConfirm: () async {
                                              await deleteParticipant(
                                                  snapshot.data![index]['id'],
                                                  Shared().userName,
                                                  Shared().id);
                                              setState(() {});
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.logout_outlined,
                                          size: 25.sp,
                                          color: MyColors().mainColors,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Date : ${snapshot.data![index]['date']}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: MyColors().mainColors),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
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
                        onConfirm: () async {
                          await addParticipant(
                              classId.text,
                              Shared().id.toString(),
                              Shared().userName.toString());
                          setState(() {});
                          classId.text = "";
                        },
                        title: "Enroll in new class",
                        titleStyle: TextStyle(color: MyColors().mainColors),
                        content: SizedBox(
                          height: 6.h,
                          child: TextFormField(
                            controller: classId,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.abc),
                                focusedBorder: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                hintText: "Class iD"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
