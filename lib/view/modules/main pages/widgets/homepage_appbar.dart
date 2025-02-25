import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/auth/logout_fun.dart';

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
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: const Icon(Icons.logout),
              ),
              const SizedBox(
                width: 10,
              )
            ],
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
