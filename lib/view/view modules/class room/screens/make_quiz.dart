import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/form_field.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/questions_part.dart.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/quiz_qusetion_class.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/save_quiz_button.dart';

class MakeQuiz extends StatefulWidget {
  const MakeQuiz({super.key});

  @override
  State<MakeQuiz> createState() => _MakeQuizState();
}

class _MakeQuizState extends State<MakeQuiz> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController quizNameCont = TextEditingController();
  TextEditingController quizScoreCont = TextEditingController();
  int numOfQuestions = 0;
  List<QuizQuestion> questions = [];
  var classId = Get.arguments['classId'];
  var eventId = Random().nextInt(10000000).toString();

  void _removeQuestion(int index) {
    setState(() {
      questions.removeAt(index);
      numOfQuestions--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Quiz"),
        centerTitle: true,
        backgroundColor: MyColors().mainColors,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                FormFieldPart(
                  keyboardType: TextInputType.text,
                  controller: quizNameCont,
                  hint: "Enter Quiz Name",
                  icon: Icons.title,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Quiz Name cannot be empty.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                FormFieldPart(
                  controller: quizScoreCont,
                  hint: "Enter Quiz Score",
                  icon: Icons.score,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Quiz Score cannot be empty.";
                    }
                    final number = int.tryParse(value);
                    if (number == null || number <= 0) {
                      return "Quiz Score must be a valid number greater than 0.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Divider(thickness: 1.5, color: MyColors().mainColors),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Questions",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: MyColors().mainColors),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          numOfQuestions++;
                          questions.add(QuizQuestion());
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 4.sp),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                QuestionsPart(
                  numOfQuestions: numOfQuestions,
                  questions: questions,
                  onRemoveQuestion: _removeQuestion,
                ),
                SizedBox(height: 2.h),
                SaveQuizButton(
                  formKey: _formKey,
                  classId: classId,
                  quizName: quizNameCont.text,
                  eventId: eventId,
                  quizScore: quizScoreCont.text,
                  questions: questions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
