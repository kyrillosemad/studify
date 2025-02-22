// events_part.dart
// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/screens/event.dart';


class EventsPart extends StatefulWidget {
  var state;
  String classId;
  EventsPart({super.key, required this.classId, required this.state});

  @override
  State<EventsPart> createState() => _EventsPartState();
}

class _EventsPartState extends State<EventsPart> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.state.length,
      itemBuilder: (BuildContext context, int index) {
        var event = widget.state[index];
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
            Get.to(const EventPage(), arguments: {
              "eventName": event['eventName'],
              "eventId": event['eventId'],
              "eventDate": formattedDate,
              "studentsScores": event['studentsScores'],
              "classId": widget.classId,
              "totalScore": event['totalScore']
            });
          },
          child: Container(
            margin: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                color: MyColors().mainColors.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.sp)),
            child: ListTile(
              title: Text(event['eventName'].toString()),
              subtitle: Text(formattedDate),
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
                        context
                            .read<EventsBloc>()
                            .add(DeleteEvent(widget.classId, event['eventId']));
                      },
                    );
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              leading: const Icon(Icons.event),
            ),
          ),
        );
      },
    );
  }
}
