import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/degrees/change_student_score.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view%20model/events/bloc/events_bloc.dart';
import 'package:studify/view/constants/colors.dart';

class AddAnotherEvent extends StatefulWidget {
  const AddAnotherEvent({super.key});

  @override
  State<AddAnotherEvent> createState() => _AddAnotherEventState();
}

class _AddAnotherEventState extends State<AddAnotherEvent> {
  final _formKey = GlobalKey<FormState>();
  final searchCont = TextEditingController();
  final eventNameCont = TextEditingController();
  final totalScoreCont = TextEditingController();
  final newScoreCont = TextEditingController();
  final classId = Get.arguments['classId'];
  late final String eventId = Random().nextInt(1000000).toString();

  // StreamController to manage search input
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    searchCont.addListener(() {
      _searchController.add(searchCont.text);
    });
  }

  @override
  void dispose() {
    _searchController.close();
    searchCont.dispose();
    eventNameCont.dispose();
    totalScoreCont.dispose();
    newScoreCont.dispose();
    super.dispose();
  }

  Stream<List<Map<String, dynamic>>> _filteredStudentsStream(
      String query) async* {
    await for (var students in getStudentsDegreesInEvent(classId, eventId)) {
      if (query.isEmpty) {
        yield students;
      } else {
        yield students.where((student) {
          return student['studentName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              student['studentId']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList();
      }
    }
  }

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
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: eventNameCont,
                            hintText: "Event Name",
                            icon: Icons.event,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Event Name cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 2.h),
                          _buildTextField(
                            controller: totalScoreCont,
                            hintText: "Total Score",
                            icon: Icons.score,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Total Score cannot be empty';
                              }
                              final score = int.tryParse(value);
                              if (score == null) {
                                return 'Total Score must be a valid number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    onCancel: () {},
                    onConfirm: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final eventName = eventNameCont.text.trim();
                        final totalScore =
                            int.parse(totalScoreCont.text.trim());

                        setState(() {
                          context.read<EventsBloc>().add(AddEvent(classId,
                              eventName, eventId, totalScore.toString(), []));
                          Get.back();
                        });
                      }
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
                hintText: "Search by Name or ID",
                icon: Icons.search,
                validator: (String? value) {
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              Text(
                "<< All Participants >>",
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: StreamBuilder<String>(
                  stream: _searchController.stream,
                  builder: (context, snapshot) {
                    final query = snapshot.data ?? '';
                    return StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _filteredStudentsStream(query),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return _buildParticipantCard(
                                  snapshot.data![index]);
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text("There's something wrong"));
                        } else {
                          return Container();
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
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
      validator: validator,
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
            final newScore = newScoreCont.text.trim();
            final score = int.tryParse(newScore);

            if (score != null &&
                score >= 0 &&
                score <= int.parse(totalScoreCont.text)) {
              await changeStudentScore(
                  classId, participant['studentId'], newScore, eventId);
              setState(() {});
              newScoreCont.clear();
              Get.back();
            } else {
              Get.snackbar(
                "Invalid Score",
                "Please enter a valid score between 0 and ${totalScoreCont.text}",
                backgroundColor: MyColors().mainColors,
                colorText: Colors.white,
              );
            }
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'New Score cannot be empty';
                    }
                    final score = int.tryParse(value);
                    if (score == null) {
                      return 'New Score must be a valid number';
                    }
                    return null;
                  },
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
