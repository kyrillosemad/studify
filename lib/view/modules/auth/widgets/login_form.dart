import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/functions/validator.dart';
import 'package:studify/view%20model/auth/login/login_bloc.dart';
import 'package:studify/view/modules/auth/widgets/role.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        var controller = context.read<LoginBloc>();
        return Form(
          key: controller.loginForm,
          child: Column(
            children: [
              SizedBox(height: 7.h),
              TextFormField(
                validator: (value) => validator(value, 30, 3, "email"),
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                controller: controller.email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: MyColors().mainColors),
                  hintText: "Email",
                  hintStyle:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                  focusedBorder: const OutlineInputBorder(),
                  disabledBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 1.h),
              TextFormField(
                obscureText: controller.secure,
                validator: (value) => validator(value, 50, 3, "password"),
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                controller: controller.password,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () => controller.add(OnPasswordToggle()),
                    child: controller.secure
                        ? Icon(Icons.visibility_off,
                            color: MyColors().mainColors)
                        : Icon(Icons.visibility, color: MyColors().mainColors),
                  ),
                  prefixIcon:
                      Icon(Icons.password, color: MyColors().mainColors),
                  hintText: "Password",
                  hintStyle:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                  focusedBorder: const OutlineInputBorder(),
                  disabledBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  "Sign in as",
                  style:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                ),
              ),
              RoleSelection(
                selectedRadio: controller.selectedRadio,
                onRadioChange: (value) {
                  controller.add(OnRadioChange(value.toString()));
                },
              ),
              SizedBox(height: 1.h),
              InkWell(
                onTap: () {
                  if (controller.loginForm.currentState!.validate()) {
                    controller.add(Login());
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
                    style: TextStyle(
                        fontSize: 13.sp, color: MyColors().mainColors),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.add(GoToSignUp());
                    },
                    child: Text(
                      "Sign UP",
                      style: TextStyle(
                          fontSize: 13.sp, color: MyColors().mainColors),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
