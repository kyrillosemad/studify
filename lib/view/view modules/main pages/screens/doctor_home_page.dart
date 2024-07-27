import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/logout_fun.dart';
import 'package:studify/services/firebase/class/add_class_fun.dart';
import 'package:studify/services/firebase/class/delete_class.dart';
import 'package:studify/services/firebase/class/get_my_classes_for_doctor.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/doctor_class_room.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  TextEditingController classNameCont = TextEditingController();
  TextEditingController classDateCont = TextEditingController();
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
                    Expanded(
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: getMyClassesForDoctor(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: MyColors().mainColors,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "Error: ${snapshot.error}",
                            style: TextStyle(
                                fontSize: 15.sp, color: MyColors().mainColors),
                          ));
                        } else if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No classes found",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var classData = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                  Get.to(const DoctorClassRoom(), arguments: {
                                    "classId": classData['id'],
                                    "className": classData['name'],
                                    "date": classData['date'],
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
                                  margin: EdgeInsets.all(5.sp),
                                  height: 12.h,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.class_,
                                      color: MyColors().mainColors,
                                    ),
                                    title: Text(
                                      classData['name'],
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
                                          title: "Delete ?",
                                          titleStyle: TextStyle(
                                              color: MyColors().mainColors),
                                          content: Text(
                                            "want to Delete this class?",
                                            style: TextStyle(
                                                color: MyColors().mainColors),
                                          ),
                                          onCancel: () {},
                                          onConfirm: () async {
                                            await await deleteClass(
                                                classData['id']);
                                            setState(() {});
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 25.sp,
                                        color: MyColors().mainColors,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Date : ${classData['date']}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: MyColors().mainColors),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ))
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
                        onConfirm: () {
                          setState(() {
                            addClassFun(classNameCont.text, classDateCont.text);
                            classNameCont.text = "";
                            classDateCont.text = "";
                          });
                        },
                        title: "New class",
                        titleStyle: TextStyle(color: MyColors().mainColors),
                        content: SizedBox(
                            height: 17.h,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: classNameCont,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.abc),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Class Name",
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFormField(
                                  controller: classDateCont,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.abc),
                                      focusedBorder: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(),
                                      hintText: "Date"),
                                )
                              ],
                            )),
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
