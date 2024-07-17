import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Name"),
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
            SizedBox(
              height: 3.h,
            ),
            const Text("event date"),
            SizedBox(
              height: 3.h,
            ),
            const Text("event id"),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: const ListTile(
                      title: Text("student name"),
                      subtitle: Text("student id"),
                      trailing: Text("student score"),
                      leading: Icon(Icons.person),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
