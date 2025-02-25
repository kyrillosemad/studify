import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/degrees/get_students_degrees_in_event.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/qrcode_container.dart';
import 'package:studify/view/modules/class%20room/widgets/take_absence_button.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

import '../widgets/participant_card.dart';

class TakeAbsence extends StatefulWidget {
  const TakeAbsence({super.key});

  @override
  State<TakeAbsence> createState() => _TakeAbsenceState();
}

class _TakeAbsenceState extends State<TakeAbsence> {
  var classId = Get.arguments['classId'];
  String eventId = Random().nextInt(1000000).toString();
  bool isready = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController eventNameCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();
  TextEditingController newScoreCont = TextEditingController();
  StreamController<String> searchStreamController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    searchCont.addListener(() {
      searchStreamController.add(searchCont.text);
    });
  }

  @override
  void dispose() {
    searchStreamController.close();
    searchCont.dispose();
    eventNameCont.dispose();
    totalScoreCont.dispose();
    newScoreCont.dispose();
    super.dispose();
  }

  Stream<List<Map<String, dynamic>>> getFilteredStudentsDegrees(
      String searchQuery) async* {
    await for (var degrees in getStudentsDegreesInEvent(classId, eventId)) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Absence"),
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
                    formKey: _formKey,
                    eventNameCont: eventNameCont,
                    totalScoreCont: totalScoreCont,
                    onConfirm: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          context.read<EventsBloc>().add(AddEvent(
                              classId,
                              eventNameCont.text,
                              eventId,
                              totalScoreCont.text, []));
                          isready = true;
                          Get.back();
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  QRCodeContainer(isReady: isready, eventId: eventId),
                  SizedBox(
                    height: 2.h,
                  ),
                  SearchField(
                    hint: "Search by Name or ID",
                    onChanged: (value) {
                      searchStreamController.add(value);
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
                    stream: searchStreamController.stream,
                    builder: (context, searchSnapshot) {
                      return StreamBuilder<List<Map<String, dynamic>>>(
                        stream: getFilteredStudentsDegrees(
                            searchSnapshot.data ?? ''),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Expanded(
                                child: Center(
                              child: CircularProgressIndicator(),
                            ));
                          } else if (snapshot.hasData) {
                 
                            return Expanded(
                              child: ParticipantsCard(
                                  participants: snapshot.data,
                               
                                  classId: classId,
                                  newScoreCont: newScoreCont,
                                  totalScoreCont: totalScoreCont,
                                  eventId: eventId),
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
  }
}
