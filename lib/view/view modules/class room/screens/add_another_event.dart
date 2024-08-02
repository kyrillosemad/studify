import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/form_field.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/new_event_button.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/participant_card.dart';

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
              NewEventButton(
                  name: "New Event",
                  classId: classId,
                  eventId: eventId,
                  eventNameCont: eventNameCont,
                  formKey: _formKey,
                  totalScoreCont: totalScoreCont),
              SizedBox(height: 3.h),
              FormFieldPart(
                  controller: searchCont,
                  hint: "Search by Name or ID",
                  icon: Icons.search,
                  validator: (String? value) {
                    return null;
                  },
                  keyboardType: TextInputType.text),
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
                          return ParticipantsCard(
                              participants: snapshot.data,
                              classId: classId,
                              newScoreCont: newScoreCont,
                              totalScoreCont: totalScoreCont,
                              eventId: eventId);
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
}
