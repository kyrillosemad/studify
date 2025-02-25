import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/quiz_qusetion_class.dart';


class SaveQuizButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String classId;
  final TextEditingController quizName;
  final String eventId;
  final TextEditingController quizScore;
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
                classId, quizName.text, eventId, quizScore.text, questionsData));
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
