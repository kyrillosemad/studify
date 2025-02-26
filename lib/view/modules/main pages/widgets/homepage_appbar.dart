import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/auth/logout_fun.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(7.h); // زيادة الارتفاع ليكون أكبر ومتجاوبًا

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 7.h, // زيادة ارتفاع التولبار ليكون أوضح
      actions: [
        InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "Logout",
              titleStyle: TextStyle(
                color: MyColors().mainColors,
                fontSize: 16.sp, // حجم متجاوب
                fontWeight: FontWeight.bold,
              ),
              buttonColor: MyColors().mainColors,
              cancelTextColor: MyColors().mainColors,
              confirmTextColor: Colors.white,
              radius: 12.sp, // زوايا ناعمة للحواف
              content: Container(
                width: 80.w, // تحديد عرض مناسب للحوار
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // تجنب التمدد غير الضروري
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app,
                        color: Colors.red, size: 24.sp), // أيقونة خروج
                    SizedBox(height: 2.h),
                    Text(
                      "Do you really want to log out?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColors().mainColors,
                        fontSize: 14.sp, // حجم متجاوب
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
              onCancel: () {},
              onConfirm: () {
                logOutFun();
              },
            );
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 4.w), // جعل التباعد متجاوبًا
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  size: 20.sp, // جعل الأيقونة متجاوبة
                ),
                SizedBox(width: 2.w), // تباعد متجاوب
              ],
            ),
          ),
        ),
      ],
      title: Text(
        "Studify",
        style: TextStyle(fontSize: 18.sp), // تكبير حجم العنوان ليكون أوضح
      ),
      backgroundColor: MyColors().mainColors,
      centerTitle: false, // جعل العنوان في المنتصف ليظهر بشكل أفضل
      elevation: 5, // إضافة ظل خفيف لإعطاء شكل أجمل
    );
  }
}
