// events_part.dart
// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/my_events/my_events_bloc.dart';

class EventsPart extends StatelessWidget {
  var state;
  String classId;
  final MyEventsBloc controller;
  EventsPart(
      {super.key,
      required this.classId,
      required this.state,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (BuildContext context, int index) {
        var event = state[index];
        if (!event.containsKey('eventDate') || !event.containsKey('eventId')) {
          return Container(
            margin: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                color: MyColors().mainColors.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.sp)),
            child: const ListTile(
              title: Text("Missing event data"),
            ),
          );
        }
        Timestamp timestamp = event['eventDate'];
        DateTime dateTime = timestamp.toDate();
        String formattedDate =
            DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
        return InkWell(
          onTap: () {
            controller.add(GoToOneEvent(
              classId,
              formattedDate,
              event['eventId'],
              event['eventName'],
              event['totalScore'],
              event['studentsScores'],
            ));
          },
          child: Container(
            margin: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                color: MyColors().mainColors.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.sp)),
            child: ListTile(
              title: Text(
                event['eventName'].toString(),
                style: TextStyle(fontSize: 12.sp),
              ),
              subtitle: Text(
                formattedDate,
                style: TextStyle(fontSize: 10.sp),
              ),
              trailing: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      buttonColor: MyColors().mainColors,
                      cancelTextColor: MyColors().mainColors,
                      confirmTextColor: Colors.white,
                      title: "Delete ?",
                      titleStyle: TextStyle(color: MyColors().mainColors),
                      content: Text(
                        "delete this event",
                        style: TextStyle(color: MyColors().mainColors),
                      ),
                      onCancel: () {},
                      onConfirm: () async {
                        controller.add(DeleteEvent(classId, event['eventId']));
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 15.sp,
                  )),
              leading: const Icon(Icons.event),
            ),
          ),
        );
      },
    );
  }
}
