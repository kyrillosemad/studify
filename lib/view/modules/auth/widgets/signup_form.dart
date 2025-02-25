import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/functions/validator.dart';
import 'package:studify/view%20model/auth/signup/signup_bloc.dart';
import 'package:studify/view/modules/auth/screens/login.dart';
import 'package:studify/view/shared_widgets/custom_text_form_field.dart';
import '../../../../core/constants/colors.dart';

class SignUpForm extends StatelessWidget {
  final SignupBloc controller;
  const SignUpForm({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Form(
          key: controller.signUpForm,
          child: Column(
            children: [
              SizedBox(height: 2.h),
              CustomTextFormField(
                name: "Username",
                controller: controller.username,
                validatorFunction: (value) =>
                    validator(value, 50, 3, "username"),
                icon: Icons.person,
                textInputType: TextInputType.text,
                obscure: false,
                suffixIcon: null,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                name: "Email",
                controller: controller.email,
                validatorFunction: (value) => validator(value, 50, 3, "email"),
                icon: Icons.email,
                textInputType: TextInputType.emailAddress,
                obscure: false,
                suffixIcon: null,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                name: "Password",
                controller: controller.password,
                validatorFunction: (value) =>
                    validator(value, 50, 4, "password"),
                icon: Icons.lock,
                textInputType: TextInputType.visiblePassword,
                obscure: controller.secure,
                suffixIcon: InkWell(
                  onTap: () => controller.add(OnPasswordToggle()),
                  child: Icon(
                    controller.secure ? Icons.visibility_off : Icons.visibility,
                    color: MyColors().mainColors,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Text("Your Role ?",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Text("Student",
                        style: TextStyle(
                            fontSize: 13.sp, color: MyColors().mainColors)),
                    Radio(
                      activeColor: MyColors().mainColors,
                      value: "student",
                      groupValue: controller.selectedRadio,
                      onChanged: (value) {
                        controller.add(OnRadioChange(value.toString()));
                      },
                    ),
                  ]),
                  Row(children: [
                    Text("Doctor",
                        style: TextStyle(
                            fontSize: 13.sp, color: MyColors().mainColors)),
                    Radio(
                      activeColor: MyColors().mainColors,
                      value: "doctor",
                      groupValue: controller.selectedRadio,
                      onChanged: (value) {
                        controller.add(OnRadioChange(value.toString()));
                      },
                    ),
                  ])
                ],
              ),
              SizedBox(height: 1.h),
              InkWell(
                onTap: () {
                  if (controller.signUpForm.currentState!.validate()) {
                    controller.add(Signup());
                  }
                },
                child: Container(
                  width: 80.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: MyColors().mainColors,
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Center(
                    child: state is SignupLoading
                        ? Lottie.asset(
                            'assets/Animation - 1740512529205.json',
                            height: 15.h,
                            fit: BoxFit.contain,
                          )
                        : Text("Sign Up",
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do you have an account ?",
                      style: TextStyle(
                          fontSize: 13.sp, color: MyColors().mainColors)),
                  TextButton(
                      onPressed: () {
                        Get.offAll(const LoginPage());
                      },
                      child: Text("Sign in",
                          style: TextStyle(
                              fontSize: 13.sp, color: MyColors().mainColors))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
