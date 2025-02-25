import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final String? Function(String?)? validatorFunction;
  final TextEditingController? controller;
  final IconData? icon;
  final TextInputType? textInputType;
  final bool obscure;
  final Widget? suffixIcon;
  const CustomTextFormField(
      {super.key,
      required this.name,
      required this.suffixIcon,
      required this.textInputType,
      required this.controller,
      required this.obscure,
      required this.icon,
      this.validatorFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      keyboardType: textInputType,
      validator: validatorFunction,
      style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: Icon(icon, color: MyColors().mainColors),
        hintText: name,
        hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
