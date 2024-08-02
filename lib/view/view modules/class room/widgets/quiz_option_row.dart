import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/view%20modules/class%20room/screens/quiz_page.dart';

class QuizOptionRow extends StatelessWidget {
  final Answers answer;
  final String optionText;
  final String value;
  final ValueChanged<String?> onChanged;

  const QuizOptionRow({
    super.key,
    required this.answer,
    required this.optionText,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10.w,
          child: Radio<String>(
            value: value,
            groupValue: answer.answer,
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: Text(optionText),
        ),
      ],
    );
  }
}
