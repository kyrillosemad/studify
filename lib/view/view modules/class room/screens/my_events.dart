import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/delete_event.dart';
import 'package:studify/data/firebase/class/my_events.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/event.dart';
import 'package:intl/intl.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  TextEditingController searchCont = TextEditingController();
  var classId = Get.arguments['classId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: const Text("My Events"),
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
                child: Text(
                  "You can find here all events you add to this class",
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
                  future: getMyEvents(classId),
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
                          "No events found",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var event = snapshot.data[index];
                          if (!event.containsKey('eventDate') ||
                              !event.containsKey('eventId')) {
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
                              DateFormat('dd MMM yyyy, hh:mm a')
                                  .format(dateTime);
                          return InkWell(
                            onTap: () {
                              Get.to(const EventPage(), arguments: {
                                "eventName": event['eventName'],
                                "eventId": event['eventId'],
                                "eventDate": formattedDate,
                                "studentsScores": event['studentsScores'],
                                "classId": classId,
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
                                        titleStyle: TextStyle(
                                            color: MyColors().mainColors),
                                        content: Text(
                                          "delete this event",
                                          style: TextStyle(
                                              color: MyColors().mainColors),
                                        ),
                                        onCancel: () {},
                                        onConfirm: () async {
                                          await deleteEvent(
                                              classId, event['eventId']);
                                          setState(() {});
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
