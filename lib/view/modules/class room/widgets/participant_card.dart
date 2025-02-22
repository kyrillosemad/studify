// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/degrees/change_student_score.dart';
import 'package:studify/view%20model/degrees/degrees_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/form_field.dart';

class ParticipantsCard extends StatefulWidget {
  var classId;
  var eventId;
  var participants;
  TextEditingController newScoreCont;
  TextEditingController totalScoreCont;
  ParticipantsCard(
      {super.key,
      required this.participants,
      required this.classId,
      required this.newScoreCont,
      required this.totalScoreCont,
      required this.eventId});

  @override
  State<ParticipantsCard> createState() => _ParticipantsCardState();
}

class _ParticipantsCardState extends State<ParticipantsCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.participants.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Get.defaultDialog(
              buttonColor: MyColors().mainColors,
              cancelTextColor: MyColors().mainColors,
              confirmTextColor: Colors.white,
              onCancel: () {},
              onConfirm: () async {
                final newScore = widget.newScoreCont.text.trim();
                final score = int.tryParse(newScore);

                if (score != null &&
                    score >= 0 &&
                    score <= int.parse(widget.totalScoreCont.text)) {
                  context.read<DegreesBloc>().add(changeStudentScore(
                      widget.classId,
                      widget.participants[index]['studentId'],
                      newScore,
                      widget.eventId));
                } else {
                  widget.newScoreCont.clear();
                  Get.snackbar(
                    "Invalid Score",
                    "Please enter a valid score between 0 and ${widget.totalScoreCont.text}",
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
                    FormFieldPart(
                        controller: widget.newScoreCont,
                        hint: "New Score",
                        icon: Icons.score,
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
                        keyboardType: TextInputType.number),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.participants[index]['studentScore'] == "0"
                  ? Colors.red
                  : Colors.green,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            margin: EdgeInsets.all(5.sp),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Text(
                widget.participants[index]['studentName'],
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                widget.participants[index]['studentId'],
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Text(
                "Score: ${widget.participants[index]['studentScore']}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
