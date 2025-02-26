// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/form_field.dart';
import 'package:studify/view/modules/class%20room/widgets/participant_card.dart';
import '../widgets/new_event_button.dart';

class AddAnotherEvent extends StatelessWidget {
  const AddAnotherEvent({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EventsBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<EventsBloc>();
            Stream<List<Map<String, dynamic>>> _filteredStudentsStream(
                String query) async* {
              await for (var students in getStudentsDegreesInEvent(
                  controller.classId, controller.eventId)) {
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

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 7.h,
                title: Text(
                  "New Event",
                  style: TextStyle(fontSize: 17.sp),
                ),
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
                          classId: controller.classId,
                          eventId: controller.eventId,
                          eventNameCont: controller.eventNameCont,
                          formKey: controller.otherEventFormKey,
                          totalScoreCont: controller.totalScoreCont),
                      SizedBox(height: 3.h),
                      FormFieldPart(
                          controller: controller.searchCont,
                          hint: "Search by Name or ID",
                          icon: Icons.search,
                          validator: (String? value) {
                            return null;
                          },
                          keyboardType: TextInputType.text),
                      SizedBox(height: 3.h),
                      Text(
                        "<< All Participants >>",
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: StreamBuilder<String>(
                          stream: controller.searchStreamController.stream,
                          builder: (context, snapshot) {
                            final query = snapshot.data ?? '';
                            return StreamBuilder<List<Map<String, dynamic>>>(
                              stream: _filteredStudentsStream(query),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: Lottie.asset(
                                    'assets/Animation - 1740512569959.json',
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                  ));
                                } else if (snapshot.hasData) {
                                  return ParticipantsCard(
                                      participants: snapshot.data,
                                      classId: controller.classId,
                                      newScoreCont: controller.newScoreCont,
                                      totalScoreCont: controller.totalScoreCont,
                                      eventId: controller.eventId);
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
          },
        ));
  }
}
