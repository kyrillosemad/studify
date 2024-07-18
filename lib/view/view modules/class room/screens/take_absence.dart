import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/add_event.dart';
import 'package:studify/data/firebase/class/change_student_score.dart';
import 'package:studify/data/firebase/class/get_all_participants_in_event.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TakeAbsence extends StatefulWidget {
  const TakeAbsence({super.key});

  @override
  State<TakeAbsence> createState() => _TakeAbsenceState();
}

class _TakeAbsenceState extends State<TakeAbsence> {
  var classId = Get.arguments['classId'];
  String eventId = Random().nextInt(1000000).toString();
  bool isready = false;
  TextEditingController eventNameCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();
  TextEditingController newScoreCont = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Take Absence"),
          backgroundColor: MyColors().mainColors,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 95.w,
              height: 100.h,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            buttonColor: MyColors().mainColors,
                            cancelTextColor: MyColors().mainColors,
                            confirmTextColor: Colors.white,
                            title: "Take Absence",
                            titleStyle: TextStyle(color: MyColors().mainColors),
                            content: Column(
                              children: [
                                TextFormField(
                                  controller: eventNameCont,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.abc),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Event name",
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFormField(
                                  controller: totalScoreCont,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.abc),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Total Score",
                                  ),
                                ),
                              ],
                            ),
                            onCancel: () {},
                            onConfirm: () {
                              setState(() {
                                addEvent(classId, eventNameCont.text, eventId,
                                    totalScoreCont.text);
                                isready = true;
                                Get.back();
                              });
                            },
                          );
                        },
                        child: Container(
                          width: 90.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Center(
                            child: Text(
                              "Take Absence",
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    isready == true
                        ? BarcodeWidget(
                            data: eventId,
                            barcode: Barcode.qrCode(),
                            width: 100.w,
                            height: 30.h)
                        : Container(
                            width: 80.w,
                            height: 35.h,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("images/qrcode_logo.png"))),
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      controller: searchCont,
                      style: TextStyle(
                          fontSize: 15.sp, color: MyColors().mainColors),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: MyColors().mainColors,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.sp))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.sp)))),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "<< all participants >> ",
                      style: TextStyle(
                          fontSize: 15.sp, color: MyColors().mainColors),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    StreamBuilder(
                      stream: getAllParticipantsInEvent(classId, eventId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Expanded(
                              child: Center(
                            child: CircularProgressIndicator(),
                          ));
                        } else if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      buttonColor: MyColors().mainColors,
                                      cancelTextColor: MyColors().mainColors,
                                      confirmTextColor: Colors.white,
                                      onCancel: () {},
                                      onConfirm: () async {
                                        await changeStudentScore(
                                            classId,
                                            snapshot.data[index]['studentId'],
                                            newScoreCont.text,
                                            eventId);
                                        setState(() {});
                                        Get.back();
                                        newScoreCont.text = "";
                                      },
                                      title: "change score",
                                      titleStyle: TextStyle(
                                          color: MyColors().mainColors),
                                      content: SizedBox(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: newScoreCont,
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(Icons.abc),
                                                focusedBorder:
                                                    OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(),
                                                hintText: "New Score",
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: snapshot.data[index]
                                                    ['studentScore'] ==
                                                "0"
                                            ? Colors.red
                                            : Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    margin: EdgeInsets.all(5.sp),
                                    child: ListTile(
                                      leading: const Icon(Icons.person),
                                      title: Text(
                                          "${snapshot.data[index]['studentName']}"),
                                      subtitle: Text(
                                          "${snapshot.data[index]['studentId']}"),
                                      trailing: Text(
                                          "score : ${snapshot.data[index]['studentScore']}"),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Expanded(
                              child: Center(
                            child: Text("there's something wrong"),
                          ));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
