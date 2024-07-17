import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/event.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
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
                    const Text(
                        "You can find here all events you add to this class"),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: InkWell(
                              onTap: () {
                                Get.to(const EventPage());
                              },
                              child: const ListTile(
                                title: Text("event name"),
                                subtitle: Text("event date"),
                                trailing: Icon(Icons.delete),
                                leading: Icon(Icons.event),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ))));
  }
}
