import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/add_event.dart';
import 'package:studify/data/firebase/class/change_student_score.dart';
import 'package:studify/data/firebase/class/get_all_participants_in_event.dart';
import 'package:studify/view/constants/colors.dart';

class AddAnotherEvent extends StatefulWidget {
  const AddAnotherEvent({super.key});

  @override
  State<AddAnotherEvent> createState() => _AddAnotherEventState();
}

class _AddAnotherEventState extends State<AddAnotherEvent> {
  TextEditingController searchCont = TextEditingController();
  var classId = Get.arguments['classId'];
  String eventId = Random().nextInt(1000000).toString();
  TextEditingController newScoreCont = TextEditingController();
  TextEditingController eventNameCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Event"),
        backgroundColor: MyColors().mainColors,
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 95.w,
          height: 100.h,
          child: Column(
            children: [
              SizedBox(height: 2.h),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                    buttonColor: MyColors().mainColors,
                    cancelTextColor: MyColors().mainColors,
                    confirmTextColor: Colors.white,
                    title: "Create New Event",
                    titleStyle: TextStyle(color: MyColors().mainColors),
                    content: Column(
                      children: [
                        _buildTextField(
                          controller: eventNameCont,
                          hintText: "Event Name",
                          icon: Icons.event,
                        ),
                        SizedBox(height: 2.h),
                        _buildTextField(
                          controller: totalScoreCont,
                          hintText: "Total Score",
                          icon: Icons.score,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    onCancel: () {},
                    onConfirm: () {
                      setState(() {
                        addEvent(
                          classId,
                          eventNameCont.text,
                          eventId,
                          totalScoreCont.text,
                          [],
                        );
                        Get.back();
                      });
                    },
                  );
                },
                child: Container(
                  width: 90.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: MyColors().mainColors,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: Text(
                      "New Event",
                      style: TextStyle(fontSize: 13.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              _buildTextField(
                controller: searchCont,
                hintText: "Search",
                icon: Icons.search,
              ),
              SizedBox(height: 3.h),
              Text(
                "<< All Participants >>",
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              StreamBuilder(
                stream: getAllParticipantsInEvent(classId, eventId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return _buildParticipantCard(snapshot.data[index]);
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Expanded(
                      child: Center(child: Text("There's something wrong")),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: MyColors().mainColors),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().mainColors),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().mainColors.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
      style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
    );
  }

  Widget _buildParticipantCard(Map<String, dynamic> participant) {
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
              participant['studentId'],
              newScoreCont.text,
              eventId,
            );
            setState(() {});
            Get.back();
            newScoreCont.text = "";
          },
          title: "Change Score",
          titleStyle: TextStyle(color: MyColors().mainColors),
          content: SizedBox(
            child: Column(
              children: [
                _buildTextField(
                  controller: newScoreCont,
                  hintText: "New Score",
                  icon: Icons.score,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: participant['studentScore'] == "0" ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        margin: EdgeInsets.all(5.sp),
        child: ListTile(
          leading: const Icon(Icons.person, color: Colors.white),
          title: Text(
            participant['studentName'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            participant['studentId'],
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: Text(
            "Score: ${participant['studentScore']}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
