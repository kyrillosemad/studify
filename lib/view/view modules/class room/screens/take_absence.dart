import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/degrees/change_student_score.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view%20model/degrees/bloc/degrees_bloc.dart';
import 'package:studify/view%20model/events/bloc/events_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController eventNameCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();
  TextEditingController newScoreCont = TextEditingController();
  StreamController<String> searchStreamController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    searchCont.addListener(() {
      searchStreamController.add(searchCont.text);
    });
  }

  @override
  void dispose() {
    searchStreamController.close();
    searchCont.dispose();
    eventNameCont.dispose();
    totalScoreCont.dispose();
    newScoreCont.dispose();
    super.dispose();
  }

  Stream<List<Map<String, dynamic>>> getFilteredStudentsDegrees(
      String searchQuery) async* {
    await for (var degrees in getStudentsDegreesInEvent(classId, eventId)) {
      if (searchQuery.isEmpty) {
        yield degrees;
      } else {
        yield degrees.where((degree) {
          return degree['studentName']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              degree['studentId']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
        }).toList();
      }
    }
  }

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
                          content: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: eventNameCont,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.event),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Event name",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the event name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFormField(
                                  controller: totalScoreCont,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.score),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Total Score",
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the total score';
                                    }
                                    final int? score = int.tryParse(value);
                                    if (score == null || score <= 0) {
                                      return 'Total score must be a positive number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          onCancel: () {},
                          onConfirm: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                context.read<EventsBloc>().add(AddEvent(
                                    classId,
                                    eventNameCont.text,
                                    eventId,
                                    totalScoreCont.text, []));
                                isready = true;
                                Get.back();
                              });
                            }
                          },
                        );
                      },
                      child: Container(
                        width: 90.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color: MyColors().mainColors,
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: Text(
                            "Take Absence",
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  isready
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
                                  image: AssetImage("images/qrcode_logo.png"))),
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
                        hintText: "Search by Name or ID",
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                        ),
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
                  StreamBuilder<String>(
                    stream: searchStreamController.stream,
                    builder: (context, searchSnapshot) {
                      return StreamBuilder<List<Map<String, dynamic>>>(
                        stream: getFilteredStudentsDegrees(
                            searchSnapshot.data ?? ''),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Expanded(
                                child: Center(
                              child: CircularProgressIndicator(),
                            ));
                          } else if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
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
                                          int? newScore =
                                              int.tryParse(newScoreCont.text);

                                          if (newScore != null &&
                                              newScore >= 0 &&
                                              newScore <=
                                                  int.parse(
                                                      totalScoreCont.text)) {
                                            context.read<DegreesBloc>().add(
                                                changeStudentScore(
                                                    classId,
                                                    snapshot.data![index]
                                                        ['studentId'],
                                                    newScoreCont.text,
                                                    eventId));
                                          } else {
                                            newScoreCont.text = "";
                                            Get.snackbar(
                                              "Invalid Score",
                                              "Please enter a valid score between 0 and ${totalScoreCont.text}",
                                              backgroundColor:
                                                  MyColors().mainColors,
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                        title: "Change Score",
                                        titleStyle: TextStyle(
                                            color: MyColors().mainColors),
                                        content: SizedBox(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: newScoreCont,
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon: Icon(Icons.score),
                                                  focusedBorder:
                                                      OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  hintText: "New Score",
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(height: 1.h),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: snapshot.data![index]
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
                                            "${snapshot.data![index]['studentName']}"),
                                        subtitle: Text(
                                            "${snapshot.data![index]['studentId']}"),
                                        trailing: Text(
                                            "score : ${snapshot.data![index]['studentScore']}"),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Expanded(
                                child: Center(
                              child: Text("There's something wrong"),
                            ));
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
