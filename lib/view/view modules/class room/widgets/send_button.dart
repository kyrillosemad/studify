import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        width: 80.w,
        height: 8.h,
        child: Center(
          child: Text(
            "Send",
            style: TextStyle(fontSize: 15.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
