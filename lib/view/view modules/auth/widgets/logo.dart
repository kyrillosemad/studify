import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage("images/logo.png")),
      ),
    );
  }
}
