
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/login_fun.dart';
import 'package:studify/view/constants/colors.dart';

import 'package:studify/view/view%20modules/auth/screens/signup.dart';
import 'package:studify/view/view%20modules/auth/widgets/role.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> loginForm;
  final TextEditingController email;
  final TextEditingController password;
  final bool secure;
  final VoidCallback onPasswordToggle;
  final String selectedRadio;
  final ValueChanged<String?> onRadioChange;

  const LoginForm({
    super.key,
    required this.loginForm,
    required this.email,
    required this.password,
    required this.secure,
    required this.onPasswordToggle,
    required this.selectedRadio,
    required this.onRadioChange,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginForm,
      child: Column(
        children: [
          SizedBox(height: 7.h),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "required field";
              } else if (value.length <= 11) {
                return "wrong Email";
              } else {
                return null;
              }
            },
            style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
            controller: email,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, color: MyColors().mainColors),
              hintText: "Email",
              hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
              focusedBorder: const OutlineInputBorder(),
              disabledBorder: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 1.h),
          TextFormField(
            obscureText: secure ? true : false,
            validator: (value) {
              if (value!.isEmpty) {
                return "required field";
              } else if (value.length <= 3) {
                return "weak password";
              } else {
                return null;
              }
            },
            style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
            controller: password,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: onPasswordToggle,
                child: secure
                    ? Icon(Icons.visibility_off, color: MyColors().mainColors)
                    : Icon(Icons.visibility, color: MyColors().mainColors),
              ),
              prefixIcon: Icon(Icons.password, color: MyColors().mainColors),
              hintText: "Password",
              hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
              focusedBorder: const OutlineInputBorder(),
              disabledBorder: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 2.h),
          Center(
            child: Text(
              "Sign in as",
              style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
            ),
          ),
          RoleSelection(
            selectedRadio: selectedRadio,
            onRadioChange: onRadioChange,
          ),
          SizedBox(height: 1.h),
          InkWell(
            onTap: () {
              if (loginForm.currentState!.validate()) {
                loginFun(email.text, password.text, selectedRadio);
              }
            },
            child: Container(
              width: 80.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: MyColors().mainColors,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account ?",
                style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(const SignUp());
                },
                child: Text(
                  "Sign UP",
                  style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
