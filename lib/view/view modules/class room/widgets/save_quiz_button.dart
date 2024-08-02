import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/events/bloc/events_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/quiz_qusetion_class.dart';

// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
class SaveQuizButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String classId;
  final String quizName;
  final String eventId;
  final String quizScore;
  final List<QuizQuestion> questions;

  const SaveQuizButton({
    super.key,
    required this.formKey,
    required this.classId,
    required this.quizName,
    required this.eventId,
    required this.quizScore,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            List<Map<String, dynamic>> questionsData = questions
                .map((question) => question.toMap())
                .toList();
            Get.back();
            context.read<EventsBloc>().add(AddEvent(
                classId, quizName, eventId, quizScore, questionsData));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors().mainColors,
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
        ),
        child: SizedBox(
          width: 80.w,
          child: Text(
            'Save the Quiz',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
