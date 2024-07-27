import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/sign_up_fun.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/auth/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool secure = true;
  String selectedRadio = "student";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: 100.w,
                height: 30.h,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image:
                        DecorationImage(image: AssetImage("images/logo.png"))),
              ),
              Container(
                  child: Column(
                children: [
                  Text(
                    "Welcome to Studify ",
                    style: TextStyle(
                        fontSize: 25.sp, color: MyColors().mainColors),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Create an new account now ",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                  ),
                ],
              )),
              Expanded(
                  child: SizedBox(
                width: 90.w,
                child: Form(
                    key: signUpForm,
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
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                          controller: username,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: MyColors().mainColors,
                              ),
                              hintText: "username",
                              hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
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
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                          controller: email,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: MyColors().mainColors,
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
                              focusedBorder: const OutlineInputBorder(),
                              disabledBorder: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
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
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                          controller: password,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: MyColors().mainColors,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    secure = !secure;
                                  });
                                },
                                child: secure == true
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
                              hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
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
                            style: TextStyle(
                                fontSize: 15.sp, color: MyColors().mainColors),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(children: [
                                  Text(
                                    "Student",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: MyColors().mainColors),
                                  ),
                                  Radio(
                                    activeColor: MyColors().mainColors,
                                    value: "student",
                                    groupValue: selectedRadio,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRadio = value.toString();
                                      });
                                    },
                                  ),
                                ]),
                              ),
                              Container(
                                child: Row(children: [
                                  Text(
                                    "Doctor",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: MyColors().mainColors),
                                  ),
                                  Radio(
                                    activeColor: MyColors().mainColors,
                                    value: "doctor",
                                    groupValue: selectedRadio,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRadio = value.toString();
                                      });
                                    },
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (signUpForm.currentState!.validate()) {
                              signUpFun(username.text, email.text,
                                  password.text, selectedRadio);
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
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do you have an account ?",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: MyColors().mainColors),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.offAll(const Login());
                                  },
                                  child: Text(
                                    "sign in",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: MyColors().mainColors),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
