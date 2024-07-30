import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/events/bloc/events_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/styles.dart';
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
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(GetEvents(classId, ''));
  }

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
                onChanged: (value) {
                  context.read<EventsBloc>().add(GetEvents(classId, value));
                },
                controller: searchCont,
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyColors().mainColors,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.sp)))),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(child: BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  if (state is EventsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is EventsError) {
                    return Center(
                      child: Text(
                        "Something Wrong ${state.msg}",
                        style: Styles().msgsStyles,
                      ),
                    );
                  }
                  if (state is EventsLoaded) {
                    if (state.events.isEmpty) {
                      return Center(
                        child: Text(
                          "There's no events",
                          style: Styles().msgsStyles,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.events.length,
                      itemBuilder: (BuildContext context, int index) {
                        var event = state.events[index];
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
                            DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
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
                                        context.read<EventsBloc>().add(
                                            DeleteEvent(
                                                classId, event['eventId']));
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
                  return const SizedBox.shrink();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
