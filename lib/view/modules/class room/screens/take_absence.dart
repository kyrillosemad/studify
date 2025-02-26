import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/qrcode_container.dart';
import 'package:studify/view/modules/class%20room/widgets/take_absence_button.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

import '../widgets/participant_card.dart';

class TakeAbsence extends StatelessWidget {
  const TakeAbsence({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EventsBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<EventsBloc>();
            Stream<List<Map<String, dynamic>>> getFilteredStudentsDegrees(
                String searchQuery) async* {
              await for (var degrees in getStudentsDegreesInEvent(
                  controller.classId, controller.eventId)) {
                if (searchQuery.isEmpty) {
                  yield degrees;
                } else {
                  yield degrees.where((degree) {
                    return degree['studentName']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        degree['studentId']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());
                  }).toList();
                }
              }
            }

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 7.h,
                title: Text(
                  "Take Absence",
                  style: TextStyle(fontSize: 17.sp),
                ),
                backgroundColor: MyColors().mainColors,
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 95.w,
                    height: 100.h,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          TakeAbsenceButton(
                            formKey: controller.absenceFormKey,
                            eventNameCont: controller.eventNameCont,
                            totalScoreCont: controller.totalScoreCont,
                            onConfirm: () {
                              if (controller.absenceFormKey.currentState!
                                  .validate()) {
                                context.read<EventsBloc>().add(AddEvent(
                                    controller.classId,
                                    controller.eventNameCont.text,
                                    controller.eventId,
                                    controller.totalScoreCont.text, []));
                                controller.isready = true;
                                Get.back();
                              }
                            },
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          BlocBuilder<EventsBloc, EventsState>(
                            builder: (context, state) {
                              return QRCodeContainer(
                                  isReady: controller.isready,
                                  eventId: controller.eventId);
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SearchField(
                            hint: "Search by Name or ID",
                            onChanged: (value) {
                              controller.searchStreamController.add(value);
                            },
                            type: TextInputType.text,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "<< all participants >> ",
                            style: TextStyle(
                                fontSize: 15.sp, color: MyColors().mainColors),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          StreamBuilder<String>(
                            stream: controller.searchStreamController.stream,
                            builder: (context, searchSnapshot) {
                              return StreamBuilder<List<Map<String, dynamic>>>(
                                stream: getFilteredStudentsDegrees(
                                    searchSnapshot.data ?? ''),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Expanded(
                                        child: Center(
                                            child: Lottie.asset(
                                      'assets/Animation - 1740512569959.json',
                                      height: 20.h,
                                      fit: BoxFit.contain,
                                    )));
                                  } else if (snapshot.hasData) {
                                    return Expanded(
                                      child: ParticipantsCard(
                                          participants: snapshot.data,
                                          classId: controller.classId,
                                          newScoreCont: controller.newScoreCont,
                                          totalScoreCont:
                                              controller.totalScoreCont,
                                          eventId: controller.eventId),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Expanded(
                                        child: Center(
                                      child: Text("There's something wrong"),
                                    ));
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
