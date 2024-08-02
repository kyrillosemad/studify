
import 'package:flutter/material.dart';

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
