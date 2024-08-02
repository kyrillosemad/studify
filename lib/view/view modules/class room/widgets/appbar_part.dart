// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:studify/view/constants/colors.dart';

class AppbarPart extends StatelessWidget {
  String name;
  AppbarPart({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors().mainColors,
      title: Text(name),
      centerTitle: true,
    );
  }
}
