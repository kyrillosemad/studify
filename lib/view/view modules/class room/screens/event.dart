import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/change_student_score.dart';
import 'package:studify/data/firebase/class/get_all_participants_in_event.dart';
import 'package:studify/view/constants/colors.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController searchCont = TextEditingController();
  String eventName = Get.arguments['eventName'];
  var eventDate = Get.arguments['eventDate'];
  var eventId = Get.arguments['eventId'];
  var classId = Get.arguments['classId'];
  var totalScore = Get.arguments['totalScore'];
  TextEditingController newScoreCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
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
              SizedBox(height: 3.h),
              Text(
                "Date : $eventDate",
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
              ),
              SizedBox(height: 3.h),
              Text(
                "ID : $eventId",
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
              ),
              SizedBox(height: 2.h),
              Center(
                child: SizedBox(
                  width: 90.w,
                  height: 7.h,
                  child: TextFormField(
                    controller: searchCont,
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.search, color: MyColors().mainColors),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontSize: 15.sp, color: MyColors().mainColors),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: StreamBuilder(
                  stream: getAllParticipantsInEvent(classId, eventId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
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
                                      newScore <= int.parse(totalScore)) {
                                    await changeStudentScore(
                                        classId,
                                        snapshot.data[index]['studentId'],
                                        newScoreCont.text,
                                        eventId);
                                    setState(() {});
                                    Get.back();
                                    newScoreCont.text = "";
                                  } else {
                                    Get.back();
                                    Get.snackbar(
                                      "Invalid Score",
                                      "Please enter a valid score between 0 and $totalScore",
                                      backgroundColor: MyColors().mainColors,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                title: "Change Score",
                                titleStyle:
                                    TextStyle(color: MyColors().mainColors),
                                content: SizedBox(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: newScoreCont,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.abc),
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
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
                              margin: EdgeInsets.all(5.sp),
                              decoration: BoxDecoration(
                                color:
                                    snapshot.data[index]['studentScore'] == "0"
                                        ? Colors.red
                                        : Colors.green,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: ListTile(
                                title: Text(
                                    "${snapshot.data[index]['studentName']}"),
                                subtitle: Text(
                                    "${snapshot.data[index]['studentId']}"),
                                trailing: Text(
                                    "Score: ${snapshot.data[index]['studentScore']} / $totalScore"),
                                leading: const Icon(Icons.person),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "There's no participants",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
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
