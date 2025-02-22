import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:studify/core/constants/colors.dart';

Future<bool> appExitAlert() {
  Get.defaultDialog(
    title: "Alert !",
    middleText: "Are You Sure To Exit App",
    cancelTextColor: MyColors().mainColors,
    confirmTextColor: Colors.white,
    buttonColor: MyColors().mainColors,
    onCancel: () {},
    onConfirm: () {
      exit(0);
    },
  );
  return Future.value(true);
}

