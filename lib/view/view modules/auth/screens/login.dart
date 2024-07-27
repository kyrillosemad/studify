import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/auth/login_fun.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/auth/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedRadio = "student";
  bool secure = true;
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
              Container(
                width: 100.w,
                height: 35.h,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image:
                        DecorationImage(image: AssetImage("images/logo.png"))),
              ),
              Container(
                  child: Column(
                children: [
                  Text(
                    "Welcome Back ",
                    style: TextStyle(
                        fontSize: 25.sp, color: MyColors().mainColors),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "login to your account",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                  ),
                ],
              )),
              Expanded(
                  child: SizedBox(
                width: 90.w,
                child: Form(
                    key: loginForm,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
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
                              prefixIcon: Icon(
                                Icons.password,
                                color: MyColors().mainColors,
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
                            "Sign in as",
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
                            if (loginForm.currentState!.validate()) {
                              loginFun(
                                  email.text, password.text, selectedRadio);
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
                                "Login",
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ?",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: MyColors().mainColors),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.offAll(const SignUp());
                                  },
                                  child: Text(
                                    "Sign UP",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: MyColors().mainColors),
                                  ))
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
