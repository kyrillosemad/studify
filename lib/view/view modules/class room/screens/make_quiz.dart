import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/events/bloc/events_bloc.dart';
import 'package:studify/view/constants/colors.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              _buildTextField(
                controller: quizNameCont,
                hintText: "Enter Quiz Name",
                icon: Icons.title,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Quiz Name cannot be empty.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              _buildTextField(
                controller: quizScoreCont,
                hintText: "Enter Quiz Score",
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
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: numOfQuestions,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildQuestionCard(index);
                  },
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      List<Map<String, dynamic>> questionsData = questions
                          .map((question) => question.toMap())
                          .toList();
                      Get.back();
                      context.read<EventsBloc>().add(AddEvent(
                          classId,
                          quizNameCont.text,
                          eventId,
                          quizScoreCont.text,
                          questionsData));
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
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: MyColors().mainColors),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().mainColors),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().mainColors.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        hintText: hintText,
      ),
      validator: validator,
    );
  }

  Widget _buildQuestionCard(int index) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(vertical: 4.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.sp,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${index + 1}",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    questions.removeAt(index);
                    numOfQuestions--;
                  });
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          _buildTextField(
            controller: questions[index].questionController,
            hintText: "Enter Question",
            icon: Icons.question_answer,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Question cannot be empty.";
              }
              return null;
            },
          ),
          SizedBox(height: 2.h),
          _buildOptionField(
              questions[index], questions[index].op1, "Option 1", "1"),
          _buildOptionField(
              questions[index], questions[index].op2, "Option 2", "2"),
          _buildOptionField(
              questions[index], questions[index].op3, "Option 3", "3"),
          _buildOptionField(
              questions[index], questions[index].op4, "Option 4", "4"),
        ],
      ),
    );
  }

  Widget _buildOptionField(QuizQuestion question,
      TextEditingController controller, String hintText, String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: question.correctOp,
          onChanged: (value) {
            setState(() {
              question.correctOp = value!;
            });
          },
        ),
        Expanded(
          child: _buildTextField(
            controller: controller,
            hintText: hintText,
            icon: Icons.edit,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "This option cannot be empty.";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class QuizQuestion {
  TextEditingController questionController;
  TextEditingController op1;
  TextEditingController op2;
  TextEditingController op3;
  TextEditingController op4;
  String correctOp;

  QuizQuestion()
      : questionController = TextEditingController(),
        op1 = TextEditingController(),
        op2 = TextEditingController(),
        op3 = TextEditingController(),
        op4 = TextEditingController(),
        correctOp = "";

  Map<String, dynamic> toMap() {
    return {
      'question': questionController.text,
      'op1': op1.text,
      'op2': op2.text,
      'op3': op3.text,
      'op4': op4.text,
      'correctOp': correctOp,
    };
  }
}
