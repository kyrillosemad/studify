import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view/modules/class%20room/widgets/participant_card.dart';
import 'package:studify/view/shared_widgets/search_field.dart';
import 'dart:async';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController searchCont = TextEditingController();
  StreamController<String> searchStreamController =
      StreamController<String>.broadcast();
  TextEditingController newScoreCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();

  String eventName = Get.arguments['eventName'];
  var eventDate = Get.arguments['eventDate'];
  var eventId = Get.arguments['eventId'];
  var classId = Get.arguments['classId'];
  var totalScore = Get.arguments['totalScore'];

  @override
  void initState() {
    super.initState();
    searchCont.addListener(() {
      searchStreamController.add(searchCont.text);
    });
    totalScoreCont.text = totalScore;
  }

  @override
  void dispose() {
    searchStreamController.close();
    searchCont.dispose();
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
                    child: SearchField(
                        hint: "Search By Name or ID",
                        onChanged: (value) {
                          searchStreamController.add(value);
                        },
                        type: TextInputType.text)),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: StreamBuilder<String>(
                  stream: searchStreamController.stream,
                  builder: (context, searchSnapshot) {
                    return StreamBuilder(
                      stream:
                          getFilteredStudentsDegrees(searchSnapshot.data ?? ''),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return ParticipantsCard(
                            participants: snapshot.data!,
                            classId: classId,
                            eventId: eventId,
                            newScoreCont: newScoreCont,
                            totalScoreCont: totalScoreCont,
                          );
                        } else {
                          return Center(
                            child: Text(
                              "There's no participants",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
                            ),
                          );
                        }
                      },
                    );
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
