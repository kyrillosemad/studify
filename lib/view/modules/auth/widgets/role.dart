

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class RoleSelection extends StatelessWidget {
  final String selectedRadio;
  final ValueChanged<String?> onRadioChange;

  const RoleSelection({
    super.key,
    required this.selectedRadio,
    required this.onRadioChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoleOption(
          label: "Student",
          value: "student",
          groupValue: selectedRadio,
          onChanged: onRadioChange,
        ),
        RoleOption(
          label: "Doctor",
          value: "doctor",
          groupValue: selectedRadio,
          onChanged: onRadioChange,
        ),
      ],
    );
  }
}

class RoleOption extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const RoleOption({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
        ),
        Radio(
          activeColor: MyColors().mainColors,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
