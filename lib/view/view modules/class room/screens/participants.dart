import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/add_participants.dart';
import 'package:studify/data/firebase/class/delete_participant.dart';
import 'package:studify/data/firebase/class/get_all_participants.dart';
import 'package:studify/view/constants/colors.dart';

class Participants extends StatefulWidget {
  const Participants({super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  TextEditingController studentNameCont = TextEditingController();
  TextEditingController studentIdCont = TextEditingController();
  var classId = Get.arguments['classId'];
  int numOfParticipants = 0;
  @override
  @override
  void initState() {
    super.initState();
    fetchParticipants();
  }

  void fetchParticipants() async {
    List<Map<String, dynamic>> part =
        await getAllParticipants(classId.toString());
    setState(() {
      numOfParticipants = part.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        centerTitle: true,
        title: Text("Participants :( $numOfParticipants )"),
      ),
      body: Center(
        child: SizedBox(
          width: 95.w,
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "You can here find all participants in this class ",
                  style:
                      TextStyle(color: MyColors().mainColors, fontSize: 15.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getAllParticipants(classId.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "there's no students ",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    } else {
                      numOfParticipants = snapshot.data!.length;

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var classData = snapshot.data![index];
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: MyColors().mainColors,
                                    offset: const Offset(0, 0),
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(
                                10.sp,
                              ),
                            ),
                            margin: EdgeInsets.all(5.sp),
                            height: 9.h,
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: MyColors().mainColors,
                              ),
                              title: Text(
                                classData['studentName'],
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: MyColors().mainColors),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    buttonColor: MyColors().mainColors,
                                    cancelTextColor: MyColors().mainColors,
                                    confirmTextColor: Colors.white,
                                    title: "Delete ?",
                                    titleStyle:
                                        TextStyle(color: MyColors().mainColors),
                                    content: Text(
                                      "delete this participants",
                                      style: TextStyle(
                                          color: MyColors().mainColors),
                                    ),
                                    onCancel: () {},
                                    onConfirm: () async {
                                      await deleteParticipant(
                                          classId,
                                          classData['studentName'],
                                          classData['studentId']);
                                      setState(() {
                                        numOfParticipants -= 1;
                                      });
                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 25.sp,
                                  color: MyColors().mainColors,
                                ),
                              ),
                              subtitle: Text(
                                "ID : ${classData['studentId']}",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: MyColors().mainColors),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      buttonColor: MyColors().mainColors,
                      cancelTextColor: MyColors().mainColors,
                      confirmTextColor: Colors.white,
                      onCancel: () {},
                      onConfirm: () async {
                        await addParticipant(
                            classId, studentIdCont.text, studentNameCont.text);
                        setState(() {
                          numOfParticipants += 1;
                        });
                        studentIdCont.text = "";
                        studentNameCont.text = "";
                      },
                      title: "New participant",
                      titleStyle: TextStyle(color: MyColors().mainColors),
                      content: SizedBox(
                        height: 17.h,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: studentNameCont,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.abc),
                                focusedBorder: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                hintText: "Student Name",
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormField(
                              controller: studentIdCont,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.perm_identity),
                                  focusedBorder: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Student ID"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: Colors.green,
                    ),
                    width: 85.w,
                    height: 7.h,
                    child: Center(
                      child: Text(
                        "Add new participant",
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
