import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view%20model/one_event_bloc/one_event_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/participant_card.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OneEventBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<OneEventBloc>();
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
                  controller.eventName,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      Text(
                        "Date : ${controller.eventDate}",
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "ID : ${controller.eventId}",
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: SizedBox(
                            width: 90.w,
                            height: 7.h,
                            child: SearchField(
                                hint: "Search By Name or ID",
                                onChanged: (value) {
                                  controller.searchStreamController.add(value);
                                },
                                type: TextInputType.text)),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: StreamBuilder<String>(
                          stream: controller.searchStreamController.stream,
                          builder: (context, searchSnapshot) {
                            return StreamBuilder(
                              stream: getFilteredStudentsDegrees(
                                  searchSnapshot.data ?? ''),
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
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return ParticipantsCard(
                                    participants: snapshot.data!,
                                    classId: controller.classId,
                                    eventId: controller.eventId,
                                    newScoreCont: controller.newScoreCont,
                                    totalScoreCont: controller.totalScoreCont,
                                  );
                                } else {
                                  return Center(
                                      child: Lottie.asset(
                                    'assets/Animation - 1740514545687.json',
                                    height: 28.h,
                                    fit: BoxFit.contain,
                                  ));
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
