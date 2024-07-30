import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/logout_fun.dart';
import 'package:studify/view/constants/colors.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        InkWell(
          onTap: () {
            Get.defaultDialog(
              buttonColor: MyColors().mainColors,
              cancelTextColor: MyColors().mainColors,
              confirmTextColor: Colors.white,
              title: "Logout",
              titleStyle: TextStyle(color: MyColors().mainColors),
              content: Text(
                "Do you really want to log out?",
                style: TextStyle(color: MyColors().mainColors),
              ),
              onCancel: () {},
              onConfirm: () {
                logOutFun();
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.all(4.sp),
            child: const Icon(Icons.logout),
          ),
        )
      ],
      title: const Text(
        "Studify",
      ),
      backgroundColor: MyColors().mainColors,
    );
  }
}