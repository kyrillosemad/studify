// sign_up_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/sign_up_fun.dart';
import 'package:studify/view/modules/auth/screens/login.dart';

import '../../../../core/constants/colors.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> signUpForm;
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  final bool secure;
  final String selectedRadio;
  final ValueChanged<bool> onSecureChanged;
  final ValueChanged<String> onRadioChanged;

  const SignUpForm({
    required this.signUpForm,
    required this.username,
    required this.email,
    required this.password,
    required this.secure,
    required this.selectedRadio,
    required this.onSecureChanged,
    required this.onRadioChanged,
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.signUpForm,
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "required field";
              } else if (value.length <= 2) {
                return "wrong name";
              } else {
                return null;
              }
            },
            style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
            controller: widget.username,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: MyColors().mainColors,
                ),
                hintText: "username",
                hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                focusedBorder: const OutlineInputBorder(),
                disabledBorder: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder()),
          ),
          SizedBox(
            height: 1.h,
          ),
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
            controller: widget.email,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: MyColors().mainColors,
                ),
                hintText: "Email",
                hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                focusedBorder: const OutlineInputBorder(),
                disabledBorder: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder()),
          ),
          SizedBox(
            height: 1.h,
          ),
          TextFormField(
            obscureText: widget.secure ? true : false,
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
            controller: widget.password,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: MyColors().mainColors,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    widget.onSecureChanged(!widget.secure);
                  },
                  child: widget.secure
                      ? Icon(
                          Icons.visibility_off,
                          color: MyColors().mainColors,
                        )
                      : Icon(
                          Icons.visibility,
                          color: MyColors().mainColors,
                        ),
                ),
                hintText: "Password",
                hintStyle: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                focusedBorder: const OutlineInputBorder(),
                disabledBorder: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder()),
          ),
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: Text(
              "Your Role ?",
              style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Text(
                  "Student",
                  style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                ),
                Radio(
                  activeColor: MyColors().mainColors,
                  value: "student",
                  groupValue: widget.selectedRadio,
                  onChanged: (value) {
                    widget.onRadioChanged(value.toString());
                  },
                ),
              ]),
              Row(children: [
                Text(
                  "Doctor",
                  style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                ),
                Radio(
                  activeColor: MyColors().mainColors,
                  value: "doctor",
                  groupValue: widget.selectedRadio,
                  onChanged: (value) {
                    widget.onRadioChanged(value.toString());
                  },
                ),
              ])
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {
              if (widget.signUpForm.currentState!.validate()) {
                signUpFun(widget.username.text, widget.email.text,
                    widget.password.text, widget.selectedRadio);
              }
            },
            child: Container(
              width: 80.w,
              height: 7.h,
              decoration: BoxDecoration(
                  color: MyColors().mainColors,
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do you have an account ?",
                style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
              ),
              TextButton(
                  onPressed: () {
                    Get.offAll(const LoginPage());
                  },
                  child: Text(
                    "sign in",
                    style: TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
