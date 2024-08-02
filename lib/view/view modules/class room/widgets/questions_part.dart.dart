// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/form_field.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/quiz_qusetion_class.dart';

class QuestionsPart extends StatefulWidget {
  final int numOfQuestions;
  final List<QuizQuestion> questions;
  final Function(int) onRemoveQuestion;

  const QuestionsPart({
    super.key,
    required this.numOfQuestions,
    required this.questions,
    required this.onRemoveQuestion,
  });

  @override
  _QuestionsPartState createState() => _QuestionsPartState();
}

class _QuestionsPartState extends State<QuestionsPart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.numOfQuestions,
        itemBuilder: (BuildContext context, int index) {
          return _buildQuestionCard(index);
        },
      ),
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
                onPressed: () => widget.onRemoveQuestion(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          FormFieldPart(
            keyboardType: TextInputType.text,
            controller: widget.questions[index].questionController,
            hint: "Enter Question",
            icon: Icons.question_answer,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Question cannot be empty.";
              }
              return null;
            },
          ),
          SizedBox(height: 2.h),
          _buildOptionField(widget.questions[index],
              widget.questions[index].op1, "Option 1", "1"),
          _buildOptionField(widget.questions[index],
              widget.questions[index].op2, "Option 2", "2"),
          _buildOptionField(widget.questions[index],
              widget.questions[index].op3, "Option 3", "3"),
          _buildOptionField(widget.questions[index],
              widget.questions[index].op4, "Option 4", "4"),
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
          onChanged: (newValue) {
            setState(() {
              question.correctOp = newValue!;
            });
          },
        ),
        Expanded(
          child: FormFieldPart(
            keyboardType: TextInputType.text,
            controller: controller,
            hint: hintText,
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
